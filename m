Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5705A138AE7
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 06:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgAMF1n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 00:27:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33016 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAMF1n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 00:27:43 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so7895406otp.0;
        Sun, 12 Jan 2020 21:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=diOYoooyO02fNaO2OaL6vZp60t8FYNXFCI94ed/4bvk=;
        b=r390DZmPSSjsz6uojt5vgUS6gXu6Gf+fYt5SWxucCUedRnTQGqaPtCa0lwYrI/9cXd
         hYmjiOIEbkgCjFVCK8g48YWIQ7KNXR7S+gYgv2jKNtNCcRAZfNo/pptKUDb6rlG+0bzh
         YFXwXSTsnoGOSMiMQdCLKFzXy03UJLk9y3qA5zNzImYRTcL3yYnixHQ5zCPBZMBxkhKu
         zNj+SEtgGH5qhDZQeEuAnnYU15bBqL7kLbzXQaLABlDQbXjjH90nbYsS6CfODW5zTysf
         iTQFU1QMUnt+CuMjheWZh9pMs7zENgQK5SibI+qPTZsjbMGGZ1RCyXTJb+MLDnX/U867
         Kgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=diOYoooyO02fNaO2OaL6vZp60t8FYNXFCI94ed/4bvk=;
        b=VdeLkOad6q7flt9JHrjZ0o9mQUyXFkz1LzDMZXkaLL3dKOimsA08vfhR/N0HqrQZ2c
         GQDtS+rZdt+E9jW8gZV+k2rzaVBFqCN7qkqr+5f9krljb+fQ8YahUK6vQGYUt9IsADMc
         V2BoNhU3NM9gEOlQ6+6qzjxE9C08g4P4RoTqUeHi9CSMpcv/MF530fDeeMTYe1j4Ny70
         8LEAJRZo9sfHQeUtsZYXpOpimAFLzEw1+sr73x4GjetssLaeQxqvBuDKU6IjMlmXY7jO
         JuNbAKiwXd/R5H0tHeDL4SvZqEAghVde0jUaB9zhZxwOK7WbhTlvwmfVP0+XzN3p5KQs
         z+mw==
X-Gm-Message-State: APjAAAXKthDNaSzhsj6AwoyNzibhUIKc/xchpTKzo4Y2dFasI0lMiOso
        VkZfOOq4BmPWjNJtlYSVVbjLkkKkHukYTPFe4yg=
X-Google-Smtp-Source: APXvYqxQ/QEMuRoeX0bGQQKxIQplQ4G0Acb+7lOL4RO8pfBHlU0rTshFrHbkTraDtgF2hpik2dSJr+Ao8uMc+r1s1mM=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr12412497otq.281.1578893262556;
 Sun, 12 Jan 2020 21:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20191112012724.250792-1-dima@arista.com> <20191112012724.250792-3-dima@arista.com>
 <ed2e65ae-75b0-ed79-0a95-90be6b82e6be@arm.com> <878smfa66i.fsf@nanos.tec.linutronix.de>
 <e74a63cb-5248-4473-81a7-d1b2f959ec7a@arm.com> <875zhja59q.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zhja59q.fsf@nanos.tec.linutronix.de>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Sun, 12 Jan 2020 21:27:31 -0800
Message-ID: <CANaxB-zrnHjmJ-7xeagiiZve69o_scPQXmZ+Y03omtk-1cqrhg@mail.gmail.com>
Subject: Re: [PATCHv8 02/34] lib/vdso: make do_hres and do_coarse as __always_inline
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        crml <criu@openvz.org>, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 10, 2020 at 4:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
> > On 1/10/20 11:42 AM, Thomas Gleixner wrote:
> >>>> +=C2=BB =C2=BB /*=C2=B7goto=C2=B7allows=C2=B7to=C2=B7avoid=C2=B7extr=
a=C2=B7inlining=C2=B7of=C2=B7do_hres.=C2=B7*/
> >>>> +=C2=BB =C2=BB goto=C2=B7out_hres;
> >>>
> >>> What is the performance impact of "goto out_hres"?
> >>
> >> On x86 it's invisible at least in my limited testing.
> >
> > On arm64 as well based on mine as well. Shall we keep the code more rea=
dable
> > here (without goto)?
>
> The delta patch below makes it readable again and also avoids the double
> inlining. Quick testing shows no difference.

My tests show no difference too and the code looks more readable. Thanks!

>
> Thanks,
>
>         tglx
