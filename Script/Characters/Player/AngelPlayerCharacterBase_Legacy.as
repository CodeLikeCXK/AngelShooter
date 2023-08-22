class AAngelPlayerChracterBaseLegacy : AAngelCharacterBase
{
    UPROPERTY(DefaultComponent)
    UInputComponent ScriptInputComponent;

    // set our turn rates for input
	float BaseTurnRate = 45.f;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
         // Set up some axis bindings to receive the values of control axes
        //  Note that these bindings consume the input and override any InputAxis nodes in the blueprint
        ScriptInputComponent.BindAxis(n"MoveForward", FInputAxisHandlerDynamicSignature(this, n"OnMoveForwardAxisChanged"));
        ScriptInputComponent.BindAxis(n"MoveRight", FInputAxisHandlerDynamicSignature(this, n"OnMoveRightAxisChanged"));

    }

     UFUNCTION()
    void OnMoveForwardAxisChanged(float32 AxisValue)
    {
        Print("Move Forward Axis Value: "+AxisValue, Duration=0.0);
        const FRotator Rotation = ControlRotation;
		const FRotator YawRotation(0, Rotation.Yaw, 0);
        const FVector Direction = YawRotation.ForwardVector;
        AddMovementInput(Direction, AxisValue);
    }

    UFUNCTION()
    void OnMoveRightAxisChanged(float32 AxisValue)
    {
        Print("Move Right Axis Value: "+AxisValue, Duration=0.0);
        const FRotator Rotation = ControlRotation;
		const FRotator YawRotation(0, Rotation.Yaw, 0);
        const FVector Direction = YawRotation.RightVector;
        AddMovementInput(Direction, AxisValue);
    }




}