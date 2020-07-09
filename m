Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2593F219D94
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 12:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGIKUc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 06:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgGIKUc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 06:20:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC6DC061A0B;
        Thu,  9 Jul 2020 03:20:32 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so788338pgn.7;
        Thu, 09 Jul 2020 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=K1VxGPW0xuJmXA1rhdwVLxJA7czyM/CyNjmy8WBsRv4=;
        b=vAFl0E6HBeNrm26G8P0UQdOfXgqNlJcA/tct4oKyTFUwEd43U7dI8PbkM8WGgVIowk
         JzOfLvU81ZaMeTJzi15ONkYEhz8ZdK1bWR7BWVaIJs/P8JDNNQZ4C6ygk426LLZ1i6Ur
         FSzzF+6FLikQrB7ZepCeoeEROzURE/Dh8X1u0DbLBpr2ry99jml6TiaDBUgmGT2TZjot
         Bs/VL2qJTGoqSBj1njDvTMQmdGXXJaLZAQkf7dMbet9Ig0o24iRlaaiRDvelEBe4Vlmq
         4o1KND3JDQfEv+NoULX20gLL2VRHXrUZDwdaew59oF71+DhmqI90PweEtb3EfegD5Mb6
         BlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=K1VxGPW0xuJmXA1rhdwVLxJA7czyM/CyNjmy8WBsRv4=;
        b=RXOIdIN/NTlrdEhKUttY8fd8Js8+szzba0AH+m3Qx6UBYApoFzhEywHs+J8SQJQd8a
         iQ6t4uERWmw8tDPA1f7ky20g1aUq76dRU7PcsS1vlgQgww1jD9e2ye/Jf1VAcgrebUFv
         HfqlSq7jCSupS6XNjdt77Guw9qNOIyHLVmjc3lTrKEnXhEcJPk8Kn8K2ElZa02I25Raa
         znKkpw8hD8GGRiXBIP8ddwvcZmOKhFiJwAsSNYNglTaQ7/QM2o086KZchDI9jRjgsn9M
         ms+4H0vmzKWbCeMQhPyt2M+rF1QjpZEaIOCkXxo7uZEoZA76EvuhUdh40fBWBrGcqWLZ
         IE7A==
X-Gm-Message-State: AOAM530cNyw2HSEhjk43BllxMR7M1HBYsifKoIa0GdJSGb3HUEQxSbT4
        un5r8S1jsvjmYVKMS/wjSEKUmydK9mZyLw==
X-Google-Smtp-Source: ABdhPJyK/kHRiKtUEQazqsog0g6PKjmX1zO9iglcz1L9RZo+7iGTY/FgnI/8ZzYcrflQm4qNDWLuzw==
X-Received: by 2002:a63:ab0d:: with SMTP id p13mr52941361pgf.327.1594290031443;
        Thu, 09 Jul 2020 03:20:31 -0700 (PDT)
Received: from localhost (27-33-0-186.tpgi.com.au. [27.33.0.186])
        by smtp.gmail.com with ESMTPSA id z2sm2453364pfq.67.2020.07.09.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 03:20:30 -0700 (PDT)
Date:   Thu, 09 Jul 2020 20:20:23 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc/64s: remove PROT_SAO support
To:     David Gibson <david@gibson.dropbear.id.au>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     kvm-ppc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
References: <20200703011958.1166620-1-npiggin@gmail.com>
        <20200703011958.1166620-3-npiggin@gmail.com>
        <20200709043406.GB2822576@thinks.paulus.ozlabs.org>
In-Reply-To: <20200709043406.GB2822576@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Message-Id: <1594288843.m3s9igh1hu.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Paul Mackerras's message of July 9, 2020 2:34 pm:
> On Fri, Jul 03, 2020 at 11:19:57AM +1000, Nicholas Piggin wrote:
>> ISA v3.1 does not support the SAO storage control attribute required to
>> implement PROT_SAO. PROT_SAO was used by specialised system software
>> (Lx86) that has been discontinued for about 7 years, and is not thought
>> to be used elsewhere, so removal should not cause problems.
>>=20
>> We rather remove it than keep support for older processors, because
>> live migrating guest partitions to newer processors may not be possible
>> if SAO is in use (or worse allowed with silent races).
>=20
> This is actually a real problem for KVM, because now we have the
> capabilities of the host affecting the characteristics of the guest
> virtual machine in a manner which userspace (e.g. QEMU) is unable to
> control.
>=20
> It would probably be better to disallow SAO on all machines than have
> it available on some hosts and not others.  (Yes I know there is a
> check on CPU_FTR_ARCH_206 in there, but that has been a no-op since we
> removed the PPC970 KVM support.)

This change doesn't change the SAO difference on the host processors
though, just tries to slightly improve it from silently broken to
maybe complaining a bit.

I didn't want to stop some very old image that uses this and is running
okay on an existing host from working, but maybe the existence of such
a thing would contradict my reasoning. But then if we don't care about
it why care about this KVM behaviour difference at all?

> Solving this properly will probably require creating a new KVM host
> capability and associated machine parameter in QEMU, along with a new
> machine type.

Rather than answer any of these questions, I might take the KVM change
out and that can be dealt with separately from guest SAO removal.

Thanks,
Nick

>=20
> [snip]
>=20
>> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/inc=
lude/asm/kvm_book3s_64.h
>> index 9bb9bb370b53..fac39ff659d4 100644
>> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
>> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
>> @@ -398,9 +398,10 @@ static inline bool hpte_cache_flags_ok(unsigned lon=
g hptel, bool is_ci)
>>  {
>>  	unsigned int wimg =3D hptel & HPTE_R_WIMG;
>> =20
>> -	/* Handle SAO */
>> +	/* Handle SAO for POWER7,8,9 */
>>  	if (wimg =3D=3D (HPTE_R_W | HPTE_R_I | HPTE_R_M) &&
>> -	    cpu_has_feature(CPU_FTR_ARCH_206))
>> +	    cpu_has_feature(CPU_FTR_ARCH_206) &&
>> +	    !cpu_has_feature(CPU_FTR_ARCH_31))
>>  		wimg =3D HPTE_R_M;
>=20
> Paul.
>=20
