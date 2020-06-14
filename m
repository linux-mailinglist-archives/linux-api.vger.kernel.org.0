Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8B1F8812
	for <lists+linux-api@lfdr.de>; Sun, 14 Jun 2020 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgFNJ0P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Jun 2020 05:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNJ0P (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Jun 2020 05:26:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0388DC03E969
        for <linux-api@vger.kernel.org>; Sun, 14 Jun 2020 02:26:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so5776655pjd.0
        for <linux-api@vger.kernel.org>; Sun, 14 Jun 2020 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=iwrVWbIqEV3s+7RFsDYwNIYHhfGqPzI2P1CNqw2alCA=;
        b=nMR4K/Mqy3PRx+ALb0wSOCgfj2S27/GQsy+gft4Tt9G7IIDoBJWqkfEWvdLq7Mno+c
         qHeFLRK9JVqJi9g+sG7BRdachupsVK6zNNeama6V7Kem7Qb8KbBrgG/ZEtjsXWj44NbI
         h0U3451Ast3krN3qKBz9b2Zhvpsva/MOHtwiQ4sweU8Ulxo0vvCM3pPYZJjYyF0dNctP
         BRwTQHaaYwdVy7QASoxWyD+wPXrcKMRhiKgAbc39xoN4WdXZ4wQG0tdRavDjWTWdAEV/
         a1ck6NiQ4KllivNeW7csw885uU76kWCJFmUo8KXfhFTLocVmWzxggESP3fNz1YAIbJHk
         CEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=iwrVWbIqEV3s+7RFsDYwNIYHhfGqPzI2P1CNqw2alCA=;
        b=sTq2mOAXoTnMmKVQePiftWypOAWwfB2h24WJKLMo8VLjw8VDBll0o7wkI1AqGI6bcW
         V0XRCWNcHYi/JrFppTynKdxCW95T2BuL9jdCREX5HaTARgffZscDYfEYFuZhB2pgUgUM
         q0gj9F6sCEW6w84OuYhKHWQTGu/wbrClx2Vrf21kpzTFQJBKyvTQAdkcOJeiQIgUiUI0
         THcw11dJnbBCY0yxg1sR4aP9iy+rH+zfWnlSBi+AgxY2EvbEae9ynOvnSEcolfupQ10v
         Mz3CAZp7jQVvFsxtkvxqwBRIAc1sBjhw4CMd9e2u7s7ej8whO8K1E7xoq8GuZnEtGyCq
         +56w==
X-Gm-Message-State: AOAM533rUdn2iSD0C/ndIkLKU9YHzryrMf6Zxi8xnKaGWhT+xUuMH8yU
        GVt5piqPN7VuY40mRprhRJk=
X-Google-Smtp-Source: ABdhPJyFqXqjBDwwikwmkiIchCvnrkZX7lREZ3x6s2VU5MZ5m6VjbNN+BDnw0N7aKFLlFyyRC8ReyA==
X-Received: by 2002:a17:90a:a62:: with SMTP id o89mr6206780pjo.188.1592126774348;
        Sun, 14 Jun 2020 02:26:14 -0700 (PDT)
Received: from localhost (193-116-108-230.tpgi.com.au. [193.116.108.230])
        by smtp.gmail.com with ESMTPSA id j184sm11173246pfg.131.2020.06.14.02.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 02:26:13 -0700 (PDT)
Date:   Sun, 14 Jun 2020 19:26:07 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     libc-dev@lists.llvm.org, linux-api@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, musl@lists.openwall.com
References: <20200611081203.995112-1-npiggin@gmail.com>
        <20200611210230.GH31009@gate.crashing.org>
In-Reply-To: <20200611210230.GH31009@gate.crashing.org>
MIME-Version: 1.0
Message-Id: <1592126681.37ybf0zhke.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Segher Boessenkool's message of June 12, 2020 7:02 am:
> Hi!
>=20
> On Thu, Jun 11, 2020 at 06:12:01PM +1000, Nicholas Piggin wrote:
>> Calling convention
>> ------------------
>> The proposal is for scv 0 to provide the standard Linux system call ABI=20
>> with the following differences from sc convention[1]:
>>=20
>> - lr is to be volatile across scv calls. This is necessary because the=20
>>   scv instruction clobbers lr. From previous discussion, this should be=20
>>   possible to deal with in GCC clobbers and CFI.
>>=20
>> - cr1 and cr5-cr7 are volatile. This matches the C ABI and would allow t=
he
>>   kernel system call exit to avoid restoring the volatile cr registers
>>   (although we probably still would anyway to avoid information leaks).
>>=20
>> - Error handling: The consensus among kernel, glibc, and musl is to move=
 to
>>   using negative return values in r3 rather than CR0[SO]=3D1 to indicate=
 error,
>>   which matches most other architectures, and is closer to a function ca=
ll.
>=20
> What about cr0 then?  Will it be volatile as well (exactly like for
> function calls)?

Yes, same as for sc (except for SO bit). Which is a bit unclear in this
section.

>> Notes
>> -----
>> - r0,r4-r8 are documented as volatile in the ABI, but the kernel patch a=
s
>>   submitted currently preserves them. This is to leave room for deciding
>>   which way to go with these.
>=20
> The kernel has to set it to *something* that doesn't leak information ;-)

For "sc" system calls these were defined as volatile (and used to just=20
leak information), so now we just zero them.

Thanks,
Nick
