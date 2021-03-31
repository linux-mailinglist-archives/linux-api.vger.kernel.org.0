Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4AE350A6D
	for <lists+linux-api@lfdr.de>; Thu,  1 Apr 2021 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhCaWps (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 18:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232600AbhCaWpW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 31 Mar 2021 18:45:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB70061090
        for <linux-api@vger.kernel.org>; Wed, 31 Mar 2021 22:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617230722;
        bh=3Npb6Zu3DJw/HynXi+oVJZahQt437+yrIYrwcSK5DQE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u1Uyl5p7jTOPv+XhIr1pdo0/HK1e9UwrBM813xOUbU/1YdwzokWEry22ijhoGpr2U
         GAb1PNvB/u0UGGluAYcoDGshCyqU4W6vkkrWIagMbfENEe/zwzP0UNuJSc7MWcbJCO
         J36YHtWXUdlx7jJFi1+yCGQcdVYCA4OkZACwrYYmcAH+H4Qi2JvkUhceUVlTt0s7id
         dG6lEyLqZIEmV+QrG7B5JdmXBOKzGmLMRQx10mlGu0hVOYoNuTuHInDmQxo8FKPcMa
         U+UrpPBTr8n/bc2eMsiO13VPdyc7ROub+92IFBc3QMJbr7Vd3clFGIh8ZzhaU7r82k
         D73DQ9tyZirwg==
Received: by mail-ej1-f51.google.com with SMTP id ap14so66595ejc.0
        for <linux-api@vger.kernel.org>; Wed, 31 Mar 2021 15:45:21 -0700 (PDT)
X-Gm-Message-State: AOAM533yQTBhpEvH4zmYaMQZ5bubQrzi+AAdT/QEXxgarU7PSkdtBH4E
        PyP+pYmb0iaip0WkUspX+R+o9XOr980CU/UD18+v2Q==
X-Google-Smtp-Source: ABdhPJyVEN9n4F0AQVaeVGiDBkMPxzCjBvJV7GTSw60MJR4FYm48tMLigo5/888YsdcsY6EAC+rkDHTd3MMn/9/PUsk=
X-Received: by 2002:a17:907:e88:: with SMTP id ho8mr6255028ejc.199.1617230720393;
 Wed, 31 Mar 2021 15:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net> <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
In-Reply-To: <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Mar 2021 15:45:09 -0700
X-Gmail-Original-Message-ID: <CALCETrW_5QDSo2sfEjBZSJ=Q3EsXTc03Unztn0Rq1caxqwtWpw@mail.gmail.com>
Message-ID: <CALCETrW_5QDSo2sfEjBZSJ=Q3EsXTc03Unztn0Rq1caxqwtWpw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Len Brown <lenb@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 31, 2021 at 3:28 PM Len Brown <lenb@kernel.org> wrote:
>
> On Wed, Mar 31, 2021 at 12:53 PM Andy Lutomirski <luto@amacapital.net> wr=
ote:
>
> > But this whole annotation thing will require serious compiler support.
> > We already have problems with compilers inlining functions and getting =
confused about attributes.
>
> We added compiler annotation for user-level interrupt handlers.
> I'm not aware of it failing, or otherwise being confused.

I followed your link and found nothing. Can you elaborate?  In the
kernel, we have noinstr, and gcc gives approximately no help toward
catching problems.

>
> Why would compiler support for fast-signals be any more "serious"?
>
> > An API like:
> >
> > if (get_amx()) {
> >  use AMX;
> > } else {
> >  don=E2=80=99t;
> > }
> >
> > Avoids this problem. And making XCR0 dynamic, for all its faults, at le=
ast helps force a degree of discipline on user code.
>
> dynamic XCR0 breaks the installed base, I thought we had established that=
.

I don't think this is at all established.  If some code thinks it
knows the uncompacted XSTATE size and XCR0 changes, it crashes.  This
is not necessarily a showstopper.

>
> We've also established that when running in a VMM, every update to
> XCR0 causes a VMEXIT.

This is true, it sucks, and Intel could fix it going forward.

>
> I thought the goal was to allow new programs to have fast signal handlers=
.
> By default, those fast signal handlers would have a stable state
> image, and would
> not inherit large architectural state on their stacks, and could thus
> have minimal overhead on all hardware.

That is *a* goal, but not necessarily the only goal.

--Andy
