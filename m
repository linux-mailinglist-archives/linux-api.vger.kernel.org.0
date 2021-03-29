Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9E34D542
	for <lists+linux-api@lfdr.de>; Mon, 29 Mar 2021 18:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhC2Qjd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Mar 2021 12:39:33 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:37675 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhC2QjL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Mar 2021 12:39:11 -0400
Received: by mail-ej1-f45.google.com with SMTP id w3so20495664ejc.4;
        Mon, 29 Mar 2021 09:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQBzHMmoWkQcaprrOUSdhejJEll5+CAI/Ph1n47/PJw=;
        b=aXJ6nCTAcMIUUMfsjlCRMqOemgfASMfudMfr7pYVFUEMyEBV/+LeHqigFZfZdvxrx/
         G/e5DSOIO7PvgAktIN6k+obCdE50ru9Q2qDUT2hnC6o0XSRN2/3HlkwKnCR8/skY3kbv
         8UOEasyunFwOpPsONnLoan9/oM47R3DSnSO/R+FPUaRslhn2xpqkBoJFwY93s64l1Q67
         n9M1DFjKdyOnrL5mE8fsK5k3pi+PRLFfK8AtvIRV3IuXVuplBlPqddrO1ps0O/IZseu5
         QLY8IumlWe9lORgVZ/y0FMRV/VwKSMf+zVCMoZRrLPcbmQceubJOR/Szw+OE8NskVQKY
         nFUg==
X-Gm-Message-State: AOAM530e/ZF0fOAQGIM3T7hmJ/KD2eivh9PxhmpvvFxbBRsdK2/TF/D9
        tvTwGXzL/CwboXRDFuROkjdbUAkNuMUhvUyMVkZ19Jvr
X-Google-Smtp-Source: ABdhPJxjNrDcuW6fqcnTahZ6x0HV9VofKao6CrqWau5z1tsA6fl+HcOu2Ky9NWP5J3t8vPib8G1j0TqQqFN0HBYRtBM=
X-Received: by 2002:a17:906:b4c:: with SMTP id v12mr29508059ejg.330.1617035950748;
 Mon, 29 Mar 2021 09:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
 <CAJvTdKm8aQPwQMXFQWgVb5dfJ88ds3d0=uHOyWeueUqfya9Nsw@mail.gmail.com>
 <YF8B3M9qihZzCf3n@kroah.com> <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
In-Reply-To: <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 29 Mar 2021 12:38:59 -0400
Message-ID: <CAJvTdKkKhCFpaWm1hb8r3GHx10KBRQvpJNTtYPSAc6m28A7sQA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> In particular, the library may use instructions that main() doesn't know exist.

And so I'll ask my question another way.

How is it okay to change the value of XCR0 during the run time of a program?

I submit that it is not, and that is a deal-killer for a request/release API.

eg.  main() doesn't know that the math library wants to use AMX,
and neither does the threading library.  So main() doesn't know to
call the API before either library is invoked.  The threading library starts up
and creates user-space threads based on the initial value from XCR0.
Then the math library calls the API, which adds bits to XCRO,
and then the user-space context switch in the threading library corrupts data
because the new XCR0 size doesn't match the initial size.

-Len
