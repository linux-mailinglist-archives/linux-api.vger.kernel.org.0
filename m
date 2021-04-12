Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFD35CF46
	for <lists+linux-api@lfdr.de>; Mon, 12 Apr 2021 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhDLROk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Apr 2021 13:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbhDLROk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Apr 2021 13:14:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1CC061574
        for <linux-api@vger.kernel.org>; Mon, 12 Apr 2021 10:14:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m11so9602573pfc.11
        for <linux-api@vger.kernel.org>; Mon, 12 Apr 2021 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ydRFGqWZoOMmHPzi9Kd+th3dU1QxHl+sPyXpHEV+QeQ=;
        b=XdlRqLMkQiuCk8Zhx3LA0oOzNjfory7c6gLmqIYqzl3kw9F6HnKvDKb10zKA+/ujRc
         9x0mh3NdAgfwygmggaWv9z6KLNX1SuRYGrrQvMiqKWdKHDFCr+bbjX872R0Nlwc7nBp9
         BOFVKMHsaSPuOx/VFNSBeAXVly/IHcUKtOiBpVYTnlLg8yR2b0IwmyRE79tsgc1DZoAU
         loVe4wf1X01/3yM0bZqxkk8JuXRd4+PaSdSlinJevZPMTw4C1CybQXANPNtkfVtbjETq
         ODwPw2WHT8UQP0zDXxc5Z8uz8XJuNpFy/ekYXBfOb5N/N3ou5jq2WAOwbes19dTkDxF4
         nP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ydRFGqWZoOMmHPzi9Kd+th3dU1QxHl+sPyXpHEV+QeQ=;
        b=s2aPEC1PsTANsaiNxf2fe51gazsswZQ48u7yATcewjMJwkr6JTK3rjFpmc6cLUm5GU
         tnf5tqe4mVogzPIssRYt3dtDt3OgzNBCImykJaD7F4x9mvPT/brr4A/b7oyxxUpME7yp
         BX+6r3v9sPxkKiKmGRsZpF1G96/K8nd8eoT7SJwb2DjCAINQDE5yoRzlrowRtcjLjAFB
         1HhWmcHOf6Pyq5RAZtakaJE1NUlzCr1nHHMX34w3dgV+7l4goyIzuTkO0xSbGgqzgLZo
         Xc8aFjuyTj8PhbBykJmIjAS9COeyagze4wQitlB+lscMeAyQicGP9AGXBKqD2tZOn5P7
         azRA==
X-Gm-Message-State: AOAM530RhIe12v3hubmkOCzh34EIe0Hv/IRb0AzTF2ZTX1sKOyH3vmb6
        bptsn99uQf1iFbBP1Pa3IAxkWw==
X-Google-Smtp-Source: ABdhPJxtukySt/qUYDnP4g7urzG6Ivq4gpQx5CpMO1HXJYv5VO3SKUXUu0NMz2g1a5qQTTZv6iEICA==
X-Received: by 2002:aa7:8d8a:0:b029:1f8:aa27:7203 with SMTP id i10-20020aa78d8a0000b02901f8aa277203mr25599322pfr.64.1618247661565;
        Mon, 12 Apr 2021 10:14:21 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id t19sm10604062pfg.38.2021.04.12.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:14:21 -0700 (PDT)
Date:   Mon, 12 Apr 2021 17:14:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <YHR/6fnpe/sAASPs@google.com>
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net>
 <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
 <CALCETrW_5QDSo2sfEjBZSJ=Q3EsXTc03Unztn0Rq1caxqwtWpw@mail.gmail.com>
 <CAJvTdKkDUywOUxb8Toth-7d4U4_S_9_EYHO38XqAPKc2_MXtdA@mail.gmail.com>
 <CALCETrXA-JzBWKdzBZJA8P+pPNKEkxNRPqLganWMpvm6KEUmCw@mail.gmail.com>
 <CAJvTdK=RFei+b0W89ZTtqoiiR_M0wAJz_EuBTijgEHpacfZS7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvTdK=RFei+b0W89ZTtqoiiR_M0wAJz_EuBTijgEHpacfZS7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Apr 11, 2021, Len Brown wrote:
> On Fri, Apr 9, 2021 at 5:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, Apr 9, 2021 at 1:53 PM Len Brown <lenb@kernel.org> wrote:
> > >
> > > On Wed, Mar 31, 2021 at 6:45 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > >
> > > > On Wed, Mar 31, 2021 at 3:28 PM Len Brown <lenb@kernel.org> wrote:
> > > > > We've also established that when running in a VMM, every update to
> > > > > XCR0 causes a VMEXIT.
> > > >
> > > > This is true, it sucks, and Intel could fix it going forward.
> > >
> > > What hardware fix do you suggest?
> > > If a guest is permitted to set XCR0 bits without notifying the VMM,
> > > what happens when it sets bits that the VMM doesn't know about?
> >
> > The VM could have a mask of allowed XCR0 bits that don't exist.
> >
> > TDX solved this problem *somehow* -- XSETBV doesn't (visibly?) exit on
> > TDX.  Surely plain VMX could fix it too.
> 
> There are two cases.
> 
> 1. Hardware that exists today and in the foreseeable future.
> 
> VM modification of XCR0 results in VMEXIT to VMM.
> The VMM sees bits set by the guest, and so it can accept what
> it supports, or send the VM a fault for non-support.
> 
> Here it is not possible for the VMM to change XCR0 without the VMM knowing.
> 
> 2. Future Hardware that allows guests to write XCR0 w/o VMEXIT.
> 
> Not sure I follow your proposal.
> 
> Yes, the VM effectively has a mask of what is supported,
> because it can issue CPUID.
> 
> The VMM virtualizes CPUID, and needs to know it must not
> expose to the VM any state features it doesn't support.
> Also, the VMM needs to audit XCR0 before it uses XSAVE,
> else the guest could attack or crash the VMM through
> buffer overrun.

The VMM already needs to context switch XCR0 and XSS, so this is a non-issue.

> Is this what you suggest?

Yar.  In TDX, XSETBV exits, but only to the TDX module.  I.e. TDX solves the
problem in software by letting the VMM tell the TDX module what features the
guest can set in XCR0/XSS via the XFAM (Extended Features Allowed Mask).

But, that software "fix" can also be pushed into ucode, e.g. add an XFAM VMCS
field, the guest can set any XCR0 bits that are '1' in VMCS.XFAM without exiting.

Note, SGX has similar functionality in the form of XFRM (XSAVE-Feature Request
Mask).  The enclave author can specify what features will be enabled in XCR0
when the enclave is running.  Not that relevant, other than to reinforce that
this is a solvable problem.

> If yes, what do you suggest in the years between now and when
> that future hardware and VMM exist?

Burn some patch space? :-)
