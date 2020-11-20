Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461A52BA138
	for <lists+linux-api@lfdr.de>; Fri, 20 Nov 2020 04:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgKTDcz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Nov 2020 22:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgKTDcz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Nov 2020 22:32:55 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6555C0613CF
        for <linux-api@vger.kernel.org>; Thu, 19 Nov 2020 19:32:53 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id d17so8512780ion.4
        for <linux-api@vger.kernel.org>; Thu, 19 Nov 2020 19:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d38N20OH6NsFFW6hbEfcAQTqk+g8cAPPY9NKAPebf0s=;
        b=C8ijzdK1s5EcO2DZ/OM3oSu9reCjA5bpGkCCx70cviaC65oblpJeIy0aFc32aIfuTy
         BwSgTkPX/PH5gD3aKSHXJibOMjMAG5Xs50V4szTqkdA3lJLkFeXvhZFm9hW4Jr5+sMSw
         pZoSC87BqMePqIv5/6NImVb7RI91tr4Hizafg+fi+fepO/tpbDFZ5aW5aU3xS7MMHiUL
         2mm+Qp6qI3JrLbET/Z4jvSeImUqcQeo/kZEXDHuBbzmQTeAJlhLWFVdmsc8ScjUkjcp4
         CT9pKhYxPglf1jC23VjfjVmi8M7B4MWIrVD5e5pYtsF4mIysP9BJ5znOCK9BXiSzW5zT
         zNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d38N20OH6NsFFW6hbEfcAQTqk+g8cAPPY9NKAPebf0s=;
        b=pZ+hizzdNT1HC1yeAsn/DBVNDonbY4PNYowJm/IGYlZq9KNRWfVIMOws+QZSTt4nRL
         PhQXTfJOnZHTDMYZ3HmOfNdvRRKFvpZDGh8Q1j5bJ9b1gJQgbKchS38zlmsbkSK9QvOq
         cvYVka4WPqDnhhCQ6WC5AUxPC5lJJfTcb4JpJnamt8rPDY8R6x9gyt00PQe0d8NHKH9v
         1/kBlPrQmM2PQ6Ms8KP3zVMht+opmN0ZUbvYefkBxq4jc01hPZcu9lfuE3Bn2BssTe61
         VxbUCs928BTB2jEkrLVuFO/o75jQZv5v1wDmOOipDXqvnMPuzPWLBUEn69wu2XcctusW
         /TZw==
X-Gm-Message-State: AOAM530StEYp6Setk9hqFXldwxwWGKCDhdse1fUCFPW01I9IZSdVqgMu
        wSR3gdb8My08UCkm+jcpx6ki48rrqEoluZpP9v6E1g==
X-Google-Smtp-Source: ABdhPJxw+T0+GruMgBNuHrma/Sii5VDSHFSOMNOY6IdpqfJfxgEvQa8iM6GNGA+pAZ1cXhWJp1M0h8zuz59GRhbQvkE=
X-Received: by 2002:a05:6638:22a6:: with SMTP id z6mr16842043jas.62.1605843173021;
 Thu, 19 Nov 2020 19:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20201119052011.3307433-1-pcc@google.com> <20201119103959.GB20578@arm.com>
In-Reply-To: <20201119103959.GB20578@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 19 Nov 2020 19:32:41 -0800
Message-ID: <CAMn1gO5U7akyCaR05rSPZBT9JyQDNaNgM9jxUjc5QSxxxSGGmQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 19, 2020 at 2:40 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
>
> The 11/18/2020 21:20, Peter Collingbourne via Libc-alpha wrote:
> > This prctl allows the user program to control which PAC keys are enabled
> > in a particular task. The main reason why this is useful is to enable a
> > userspace ABI that uses PAC to sign and authenticate function pointers
> > and other pointers exposed outside of the function, while still allowing
> > binaries conforming to the ABI to interoperate with legacy binaries that
> > do not sign or authenticate pointers.
> >
> > The idea is that a dynamic loader or early startup code would issue
> > this prctl very early after establishing that a process may load legacy
> > binaries, but before executing any PAC instructions.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/Ibc41a5e6a76b275efbaa126b31119dc197b927a5
>
> i would mention in the commit that the overhead of the kernel entry
> code change was measured to be small.

Done.

> > ---
> > v3:
> > - fix some style nits
> > - move kernel entry ISB to after setting EnIA
> > - rename sctlr -> sctlr_user
> > - remove init_sctlr
> >
> > v2:
> > - added prctl(PR_PAC_GET_ENABLED_KEYS)
> > - added ptrace APIs for getting and setting the set of enabled
> >   keys
> > - optimized the instruction sequence for kernel entry/exit
> > - rebased on top of MTE series
> ...
> > +Enabling and disabling keys
> > +---------------------------
> > +
> > +The prctl PR_PAC_SET_ENABLED_KEYS allows the user program to control which
> > +PAC keys are enabled in a particular task. It takes two arguments, the
> > +first being a bitmask of PR_PAC_APIAKEY, PR_PAC_APIBKEY, PR_PAC_APDAKEY
> > +and PR_PAC_APDBKEY specifying which keys shall be affected by this prctl,
> > +and the second being a bitmask of the same bits specifying whether the key
> > +should be enabled or disabled. For example::
> > +
> > +  prctl(PR_PAC_SET_ENABLED_KEYS,
> > +        PR_PAC_APIAKEY | PR_PAC_APIBKEY | PR_PAC_APDAKEY | PR_PAC_APDBKEY,
> > +        PR_PAC_APIBKEY, 0, 0);
> > +
> > +disables all keys except the IB key.
> > +
> > +The main reason why this is useful is to enable a userspace ABI that uses PAC
> > +instructions to sign and authenticate function pointers and other pointers
> > +exposed outside of the function, while still allowing binaries conforming to
> > +the ABI to interoperate with legacy binaries that do not sign or authenticate
> > +pointers.
> > +
> > +The idea is that a dynamic loader or early startup code would issue this
> > +prctl very early after establishing that a process may load legacy binaries,
> > +but before executing any PAC instructions.
>
> please document how the setting is inherited across clone, fork, exec
> and the setting at process startup (since it wont be inherited across
> exec and not every reader knows what setting is required for bw compat).

Done. (Sorry, I said that I would do that then forgot to actually do
it.) While I was here I also documented the perf difference between IA
and the other keys.

Peter
