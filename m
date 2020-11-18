Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEE2B845E
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 20:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKRTGG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 14:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgKRTGF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Nov 2020 14:06:05 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB955C0613D4
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:06:05 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id j12so3235239iow.0
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ee067VJcwdxUc3ftbuvjK6kCxcAaxiVZ8ffPztdFzfk=;
        b=DpyKtQ5GoI0Q3F/v51/h8gLhf/IRwukrMKOCGbjBEDDapPelg/AzJBv6TBXeAGF4KA
         aUWx51wzqhNBbj/5/jTV3+KuPUrnodnbteMt8fcOUvuxnbKgdLoVCnmGHROiqeIDhvI2
         jr93s2dVKXVR5uaqnUycVuUZ/Xu1k9o0GnmxC9eeH9LwPUbhJiZ0h4X3D4SS/hKBRgEJ
         Yh6DAQEL8xiOPZ5AUq1/alYhJqQjDyP/nRjuIcDeh7rZ5erL6XfN8fP32f6lctQKYVJu
         hVclLcuBxuESqOV+oXcyX6yjt7VmBka5s5p6XW7EJoFN6pjong9cW8y/iRFaYnOG9vZ4
         mUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ee067VJcwdxUc3ftbuvjK6kCxcAaxiVZ8ffPztdFzfk=;
        b=nni3GvuGVNcVY730/X1o2z4tb3+af+8gp3t7CjAgHCdUiG+2EKwhD1ThpKtsuXQo6v
         EJjVqd0JESsro7HFYpB9NJQO2RgCaZ8jssMkcyZGKDa8UOAPi0UZY6+vYYp17eokDyux
         1FtZyIuKzlpfLweBoVo4sOhRVgd8Bm6Miob68SvmN64L5e32S9cCw0cOf6Qzz7r2bxht
         FOJxlFkt/S/bRisUNHBy1ekMONX1TQ5LRyW8TKz8VPoymmobEf+/V8SPVQJixhtedk3i
         Fos4iVOh2yhj+WRHKRqv+8uJ9pc6oWoeMcARTIKDKvGTHj64IRpNLm/Uq28aZpaJH62l
         KIuQ==
X-Gm-Message-State: AOAM5333Pv2/vdxweSNlqHzg0cHs9kOItKDzXXHybhoGum+Ry19UGFgg
        xuLNMS414WdXqXET3RbFXR6ZekTFtIfzc+r7U2+2wQ==
X-Google-Smtp-Source: ABdhPJwXYd1me09sJbtRxvat0lzWNk8YKiIbjxC6vTjkhCmuBjuOqVG3cwXOyBmCx3U21qtn2FXwsKM9ECuroR81wQo=
X-Received: by 2002:a02:cc77:: with SMTP id j23mr9917746jaq.20.1605726364728;
 Wed, 18 Nov 2020 11:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20201014055106.25164-1-pcc@google.com> <20201118175539.GH6882@arm.com>
In-Reply-To: <20201118175539.GH6882@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 18 Nov 2020 11:05:54 -0800
Message-ID: <CAMn1gO7DMx7ty3+09M49wAs-JCEH1H2T13-VxKXCeUz0oGj=Wg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 18, 2020 at 9:55 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Tue, Oct 13, 2020 at 10:51:06PM -0700, Peter Collingbourne wrote:
> > This prctl allows the user program to control which PAC keys are enabled
> > in a particular task. The main reason why this is useful is to enable a
> > userspace ABI that uses PAC to sign and authenticate function pointers
> > and other pointers exposed outside of the function, while still allowing
> > binaries conforming to the ABI to interoperate with legacy binaries that
> > do not sign or authenticate pointers.
>
> Does this boil down to using the B key(s) to sign pointers that flow
> across library boundaries?

Right, the B key or whichever I key you select as part of the
interprocedural ABI (most likely B to avoid the kernel's entry/exit
slow path if it needs to be disabled).

> ld.so would then need a control to turn off the B key off if, say,
> the main program or some random library it uses hasn't been rebuilt
> to enable this signing.
>
> (I think we discussed this before, but I keep forgetting the exact
> rationale.)

See [1] where we discussed this before.

> > The idea is that a dynamic loader or early startup code would issue
> > this prctl very early after establishing that a process may load legacy
> > binaries, but before executing any PAC instructions.
>
> We probably need a new program property in ELF to describe this.

There is a draft PAuth ABI [2] which will specify how the feature
works in ELF. I believe that the specification will include details of
how the ELF markings are going to work.

> Currently, there is GNU_PROPERTY_AARCH64_FEATURE_1_PAC, which does not
> specify a key -- but I think it could be defined retrospectively to
> apply to just the APIA key, say.
>
> This raises the question of whether the kernel should actually turn the
> keys on or off based on these flags.  For historical compatibility,
> probably not -- but we could perhaps do that for the B key since the ABI
> for use of the B key is entirely unstandardised so far.

I would be against having the kernel read any ELF properties at this
point. All of the processing can be done in the dynamic loader, and
ELF properties are strictly less powerful than having the dynamic
loader decide what to do. It's not enough to look at the main
executable anyway because you would also need to read the recursive
dynamic libraries and that's a task better done in userspace.
Userspace may also require more complex logic than what can be
expressed with ELF properties (for example, on Android we would need
the same executable to be launched twice, once with keys enabled and
once with keys disabled). If we do anything at all it should probably
be based on whatever we come up with for the PAuth ABI which hasn't
been finalized yet.

> I'll take a look at the patch tomorrow -- my brain isn't functioning
> right now.

Thanks.

Peter

[1] https://lore.kernel.org/linux-arm-kernel/CAMn1gO5JV4-xDO0TAJcY8DmNVgZb_sBH=RUEQY1gTUmmFPGHqQ@mail.gmail.com/
[2] https://github.com/ARM-software/abi-aa/blob/master/pauthabielf64/pauthabielf64.rst
