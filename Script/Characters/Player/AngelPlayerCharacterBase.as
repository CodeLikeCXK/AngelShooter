class AAngelPlayerCharacterBase : AAngelCharacterBase
{
    // set our turn rates for input
	float BaseTurnRate = 45.f;


    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Camera", Attach = CollisionCylinder)
    USpringArmComponent CameraBoom;
    // Set default values for subobjects with `default` statements
    // No need and no function of CreatedefaultSubObject
    
    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Camera", Attach = CameraBoom)
    UCameraComponent Camera;
    
    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        
    }





}