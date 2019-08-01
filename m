Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E937D543
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 08:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfHAGKS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 02:10:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32877 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAGKS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Aug 2019 02:10:18 -0400
Received: from [IPv6:2601:646:8600:3281:f549:c2d0:4f21:f394] ([IPv6:2601:646:8600:3281:f549:c2d0:4f21:f394])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x7169TFe4004431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 31 Jul 2019 23:09:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x7169TFe4004431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564639782;
        bh=hj4XLnWmaqXTliAjlGiL/tNc3I1ADZJcqQ2Xbh5pybc=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=1R5ScGiUiT/AKNgnBJZVD+Yzs4BenICfhc/hiOMvQTDCsJLO/oZiKUr/AU+WxppBg
         xIOi7INakhU3dDsKqlfmr6Au0b+rQ6mScDwLXbqw98QaanC9XPxyJk9tyikd776tto
         Ni4m9PdTrzQKw0cvpA5KH3ZTlDFuo9JMLsV2cKEd+oztUZrnYJ7lRcUT+cIBB8vV5I
         cljsVaSkX598DyxVmj/jmh6HYNSLpnGnz+dypFp4egRrtySlyaR3kYp9HFKV5bPkdr
         k7lpuQy8oEJX6lAHhxxcoEDXf5dUyR51V0MPRyTxwz/zZteZ3Mm4HGWUKvKZ+l7HR2
         q/+Ol/ldfFJAw==
Date:   Wed, 31 Jul 2019 23:09:20 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrUpOhTCQkhB3S73LBFAiTp07PwXP32Q6Bn0m2LTqiw9hA@mail.gmail.com>
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-26-dima@arista.com> <CALCETrUpOhTCQkhB3S73LBFAiTp07PwXP32Q6Bn0m2LTqiw9hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv5 25/37] x86/vdso: Switch image on setns()/clone()
To:     Andy Lutomirski <luto@kernel.org>, Dmitry Safonov <dima@arista.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andrei Vagin <avagin@gmail.com>
From:   hpa@zytor.com
Message-ID: <4D0E6734-066D-4A72-A119-2FD6482F857D@zytor.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On July 31, 2019 10:34:26 PM PDT, Andy Lutomirski <luto@kernel=2Eorg> wrote=
:
>On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista=2Ecom> wrote:
>>
>> As it has been discussed on timens RFC, adding a new conditional
>branch
>> `if (inside_time_ns)` on VDSO for all processes is undesirable=2E
>> It will add a penalty for everybody as branch predictor may
>mispredict
>> the jump=2E Also there are instruction cache lines wasted on cmp/jmp=2E
>
>
>>
>> +#ifdef CONFIG_TIME_NS
>> +int vdso_join_timens(struct task_struct *task)
>> +{
>> +       struct mm_struct *mm =3D task->mm;
>> +       struct vm_area_struct *vma;
>> +
>> +       if (down_write_killable(&mm->mmap_sem))
>> +               return -EINTR;
>> +
>> +       for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
>> +               unsigned long size =3D vma->vm_end - vma->vm_start;
>> +
>> +               if (vma_is_special_mapping(vma, &vvar_mapping) ||
>> +                   vma_is_special_mapping(vma, &vdso_mapping))
>> +                       zap_page_range(vma, vma->vm_start, size);
>> +       }
>
>This is, unfortunately, fundamentally buggy=2E  If any thread is in the
>vDSO or has the vDSO on the stack (due to a signal, for example), this
>will crash it=2E  I can think of three solutions:
>
>1=2E Say that you can't setns() if you have other mms and ignore the
>signal issue=2E  Anything with green threads will disapprove=2E  It's als=
o
>rather gross=2E
>
>2=2E Make it so that you can flip the static branch safely=2E  As in my
>other email, you'll need to deal with CoW somehow,
>
>3=2E Make it so that you can't change timens, or at least that you can't
>turn timens on or off, without execve() or fork()=2E
>
>BTW, that static branch probably needs to be aligned to a cache line
>or something similar to avoid all the nastiness with trying to poke
>text that might be concurrently executing=2E  This will be a mess=2E

Since we are talking about different physical addresses I believe we shoul=
d be okay as long as they don't cross page boundaries, and even if they do =
it can be managed with proper page invalidation sequencing =E2=80=93 it's n=
ot like the problems of having to deal with XMC on live pages like in the k=
ernel=2E

Still, you really need each instruction sequence to be present, with the o=
nly difference being specific patch sites=2E

Any fundamental reason this can't be strictly data driven? Seems odd to me=
 if it couldn't, but I might be missing something obvious=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
