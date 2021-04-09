Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8218D35A82F
	for <lists+linux-api@lfdr.de>; Fri,  9 Apr 2021 22:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhDIUz4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Apr 2021 16:55:56 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:38876 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbhDIUz4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Apr 2021 16:55:56 -0400
Received: by mail-ej1-f41.google.com with SMTP id r12so10710722ejr.5;
        Fri, 09 Apr 2021 13:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6269CFEcO294v7exi47GLnYJ4w/SXpoLX7EH0IrfMXg=;
        b=UbrfMgP8uF59OblaqqhqB7XmhIo5yfVh9fr1UBXE+4jDPUIfi7SnMrsEPhaXld87Ds
         KihSi+fuzN5JVdwQNaP372w5aEjFdHPSdzJeFbWuNbhZKmJkMJ2jfQpUb9TH7SOrpQgG
         gntMmyBu8RfXqrMru0HNCMlRkygoOka8QK9B2mUtAm2PMArtoM5cxxMxcF60nHZlbRR4
         NlkHmCkZ7vQpSgaQmb9d1R+9tdOP/WI/Hb8eZUK3uHP+Yvr6IoFaVMnCfQqTKRqpsuAu
         hQTlEhciIBwBHuyyTE8p5N6ZzilHHVjgtXdtXN2EgrCjYWLmyuyoel2S3kHIAf7v43uF
         kSsQ==
X-Gm-Message-State: AOAM530eerdaWTOWp0DQ7w6L+4/QXtq6Y1qK4Syds3wq7Vh7n37orkHX
        Sa47WY+ctjI8hffm6lpDE463JsPW0SJaBYik1KY=
X-Google-Smtp-Source: ABdhPJwXzE1P09vuf4uHOZgcOVQmGC/sR9VCWa3xvIkBzLtB6ZptwLRWU6jAe3sPnSByf6nG5X9sVE7VQUX0uxjWpeY=
X-Received: by 2002:a17:906:dfcc:: with SMTP id jt12mr17795157ejc.31.1618001741712;
 Fri, 09 Apr 2021 13:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net> <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
 <20210331225226.GC11673@zn.tnic>
In-Reply-To: <20210331225226.GC11673@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 9 Apr 2021 16:55:30 -0400
Message-ID: <CAJvTdKm_sa869Xn-GVFPnka_B+-otf1FwoMtA-8PAYOaN99BnA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
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
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 31, 2021 at 6:54 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Mar 31, 2021 at 06:28:27PM -0400, Len Brown wrote:
> > dynamic XCR0 breaks the installed base, I thought we had established
> > that.
>
> We should do a clear cut and have legacy stuff which has its legacy
> expectations on the XSTATE layout and not touch those at all.
>
> And then all new apps which will use these new APIs can go and request
> whatever fancy new state constellations we support. Including how they
> want their signals handled, etc.
>
> Fat states like avx512, amx etc will be off by default and apps
> explicitly requesting those, can get them.
>
> That's it.

100% agreement from me!  (does anybody disagree?)

thanks,
Len Brown, Intel Open Source Technology Center
