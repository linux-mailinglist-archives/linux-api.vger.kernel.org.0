Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2E350A3D
	for <lists+linux-api@lfdr.de>; Thu,  1 Apr 2021 00:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhCaW2t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 31 Mar 2021 18:28:49 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37676 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhCaW2j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Mar 2021 18:28:39 -0400
Received: by mail-ed1-f51.google.com with SMTP id x21so24086316eds.4;
        Wed, 31 Mar 2021 15:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qO/MnGOAo2aKNNZIMFKn7K57e/u6m6J452MXAoHJnn0=;
        b=VxVbnybetLd06dvzjpOW7fRjTvptvQ0C9ydDaWd+Tj7B6saGjfrdIOPAL9/cUfjT5q
         o43IS5hAL25S7NS0tQiBZQcjlJScLBn435uQKeauFeCiH6kmTfOS2kFj1P3c08mrRtvW
         FMR9yfTsp9fdvEuWh0i1jfVK3CJXkPqReU5w2sJ168yg9xN+PSACNqeMZl/23JtOtRMy
         VONuR4SjF+wpHNyIl9GOk+9GSY5yydc4txbOF43bbnqcwnfIizBXyYq4etC40Thcx511
         nJ12sjzTWOWMJ9p8cyrtts2xpCxhspdDJpBqhdx35CCjxDKOvSKyjej1ZjVx+QucSWu4
         iPjg==
X-Gm-Message-State: AOAM530u+z8xAahD2aaL/+bdJK+vwr7rs/MLqUeD6muOaQxINCP8BKOi
        kWkZQz/F2VZeeChIDZ5Mj0NZ3HjZZgc98F6rZV0=
X-Google-Smtp-Source: ABdhPJyCavZ4RcFBgd4wNh9CfsMfm1DD0nwSyeJZ5JeXCQN+/vQREPStBukJfuirUEvE5rOX7izGJkTaySudPgwlUhA=
X-Received: by 2002:aa7:d917:: with SMTP id a23mr6502007edr.122.1617229718626;
 Wed, 31 Mar 2021 15:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net>
In-Reply-To: <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 31 Mar 2021 18:28:27 -0400
Message-ID: <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@amacapital.net>
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 31, 2021 at 12:53 PM Andy Lutomirski <luto@amacapital.net> wrote:

> But this whole annotation thing will require serious compiler support.
> We already have problems with compilers inlining functions and getting confused about attributes.

We added compiler annotation for user-level interrupt handlers.
I'm not aware of it failing, or otherwise being confused.

Why would compiler support for fast-signals be any more "serious"?

> An API like:
>
> if (get_amx()) {
>  use AMX;
> } else {
>  don’t;
> }
>
> Avoids this problem. And making XCR0 dynamic, for all its faults, at least helps force a degree of discipline on user code.

dynamic XCR0 breaks the installed base, I thought we had established that.

We've also established that when running in a VMM, every update to
XCR0 causes a VMEXIT.

I thought the goal was to allow new programs to have fast signal handlers.
By default, those fast signal handlers would have a stable state
image, and would
not inherit large architectural state on their stacks, and could thus
have minimal overhead on all hardware.
