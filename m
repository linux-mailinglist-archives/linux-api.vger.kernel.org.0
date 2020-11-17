Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7222B6EAF
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 20:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgKQTck (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 14:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgKQTcj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 14:32:39 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AF1C0617A6
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 11:32:39 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 11so25662215ljf.2
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 11:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGL6qEm8WTey1fegAUB+rgCMznJuzrepIZTG6os33Yk=;
        b=ikuAIikF7K3wb1fPapuNBCcS6tEh+cF2uqZZYsMNqEduiVBZeDTlPPDQT9zRJceVR2
         Q+Zafi3u5KvVbLwaPsq/ifcwMsZjRttpSP74HmxEwO4DV8bUy8yQKepxY28aNBhEOYUV
         i79prNxwRj5QVZkYPIhKNQ2Uf+jhQesfqV205Rxvh9h9OcoP05ZsqVfAFT6PhqlK4WtS
         4LRdIn15ajLdJaLMvImjsTI0/nYvj+41N5ol2FgShezice4jc3Zq5s0ywfIBtGqDl5Vn
         M2UcJOANX0P4gBi0c9ElXV4ZcZZIvU0wU7thMXaT0DWyfub9YfzWqKqj2XB5laOHWpr5
         iQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGL6qEm8WTey1fegAUB+rgCMznJuzrepIZTG6os33Yk=;
        b=Hk391czDZUsgz7dEK9WbZpWOpsyyxnHaVoCycn+i53dQwci4mX7e8hszT5pXgIvsK+
         UjXmvG4SW/zeKiHiStjD7Op5cNY1OMxS6YmNOR47gH4YH5++emqyLvrtKXCvpSMQESlX
         f8UUoS5ZJmPvokZ5DQEOCjxMOXAP0dwUD41HQ1WMTwMbttIeGGpi3QUPTItw0+tnUjwQ
         84ZRTMDVHrpwVyLG6o/PQE5hSQCawBDI+18N9LIpISdRIwtrYQuoH9IEZGaJHg0u/jvf
         fzaPgnIPsyeJm+mE4Ub1m4d+NPkuJPcDkLHaZYp44bk6ZnlxfTYDhqOAnS5XdgPUIG02
         Ba5w==
X-Gm-Message-State: AOAM533FNdmXK8Cy3fMmZDIpfZe88Qs6r1I3Hdbm1V1v9lpUm/XqafiR
        YwmF80xkQ6jsM0yX/zfLSoDDzWomiasdOKsXXnD63w==
X-Google-Smtp-Source: ABdhPJytYxb+/lBqBar7MAMMAWMn/yFZRROhBkOCns4p6CfhbKyf+d9gs675sLsrmmLYJzjr9weW5Vv9qtmjxa6JKfE=
X-Received: by 2002:a2e:58d:: with SMTP id 135mr2344100ljf.387.1605641557901;
 Tue, 17 Nov 2020 11:32:37 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
 <87k0uj6h03.fsf@mid.deneb.enyo.de> <20201117183652.GD2672@gate.crashing.org>
 <87r1or4yct.fsf@mid.deneb.enyo.de> <CAPNVh5d2u84t9RV7kg6PYJc5eGFrEQV__aDX6AC2V4-s+msFvA@mail.gmail.com>
 <1828724974.48168.1605640886598.JavaMail.zimbra@efficios.com>
In-Reply-To: <1828724974.48168.1605640886598.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 17 Nov 2020 11:32:26 -0800
Message-ID: <CAPNVh5dg6jRTp0VGwxq_JBuqxw+AFi2mYxa-wk+=PKja6dEK2Q@mail.gmail.com>
Subject: Re: Is adding an argument to an existing syscall okay?
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 17, 2020 at 11:21 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Nov 17, 2020, at 1:58 PM, Peter Oskolkov posk@google.com wrote:
>
> > My assumption here was that applications that are aware of the new API
> > will always provide three parameters, while older applications will
> > continue calling the syscall with two.
> >
> > I can't think of a situation/architecture where this will break anything.
>
> I think what Florian refers to here is if there would be a glibc library
> wrapper exposing the system call to applications. There, the number of
> arguments would matter. But it does not exist today.
>
> In some sense, it's a good thing that there isn't such wrapper exposed
> yet. It also makes me wonder whether exposing system calls directly as a
> library ABI is a good thing. It appears that library ABIs have stronger
> restrictions with respect to number and types of parameters than system
> calls.

Technically, a library that exposes membarrier() with two parameters
can just add membarrier_ex() or whatever with three parameters, not
breaking anything. From the final user perspective, this would look exactly
as if we added a new syscall membarrier_ex.

So the question becomes whether it is better to add a new syscall and a new
library function, or just add another parameter to the existing
syscall, and a new
library function, and the answer to this question is more about policy
than about
technical merits of the two approaches.

I have no comments on policy matters here - this is up to maintainers. :)

Thanks,
Peter

[...]
