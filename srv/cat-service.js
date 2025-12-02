module.exports = cds.service.impl(async function(){
    // Step-1 : Collect the service definitions from the form objects
    const { EmployeeS, POs } = this.entities;

    // Step-2 : Define the generic handler for the validation using BEFORE
    this.before('CREATE', EmployeeS, (request, response) => {
        console.log("The salary amount : " + request.data.salaryAmount);
        if(parseFloat(request.data.salaryAmount) >= 100000){
            request.error(500, "You will require line manager approval!");
        }
    });

    // Custom Action - To perform DB operations, Get the data from S4H, Extract data from Palatir Foundry, Post the data
    this.on('createEmployee', async(request, response)=>{
        const dataset = request.data;
        let returndata = await cds.tx(request).run([
            INSERT.into(EmployeeS).entries(dataset)
        ]).then((resolve,reject)=>{
            if(typeof(resolve) !== undefined){
                return request.data;
            } else {
                request.error(500,"Error in creation of Employee")
            }
        }).catch(error =>{
            request.error(500,"There is an error " + error.toString());
        });
        
        return returndata;
    });

    // Instance Bounded Action - To perform DB operations, Get the data from S4H, Extract data from Palatir Foundry, Post the data
    this.on('discountPrice', async(request, response)=>{
       try {
        const ID  = request.params[0];

        const tx = cds.tx(request);

        await tx.update(POs).with({
            GROSS_AMOUNT : {'-=' : 500},
            NET_AMOUNT : {'-=' : 500},
            NOTE : 'Discounted..!'
        }).where(ID);
       } catch (error) {
        return "Error" + error.toString();
       }
    });


    // Instance Bounded Action - To perform DB operations, Get the data from S4H, Extract data from Palatir Foundry, Post the data
    this.on('largestOrder', async(request, response)=>{
       try {

        const tx = cds.tx(request);
        const reply = await tx.read(POs).orderBy({
            GROSS_AMOUNT: 'desc'
        }).limit(5);

        return reply;
       } catch (error) {
        return "Error" + error.toString();
       }
    });

    // Custom Function
    this.on('getAllEmployees', async(request, response)=>{
        try {
            const returndata = await cds.tx(request).read(EmployeeS).orderBy({
                nameFirst: 'asc'
            }).limit(10);

            return returndata;
        } catch(error){
            return "Error : " + error.toString();
        }
/*        let returndata = await cds.tx(request).run([
            SELECT.from('INFY_SD_POA_DB_MASTER_EMPLOYEES')
        ]).then((resolve,reject)=>{
            if(typeof(resolve) !== undefined){
                return request.data;
            } else {
                request.error(500,"Error in creation of Employee")
            }
        }).catch(error =>{
            request.error(500,"There is an error " + error.toString());
        });
        
        return returndata; */
    });
})