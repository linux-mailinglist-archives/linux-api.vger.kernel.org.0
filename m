Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC8834B59B
	for <lists+linux-api@lfdr.de>; Sat, 27 Mar 2021 10:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhC0JPe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 27 Mar 2021 05:15:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40430 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhC0JPE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 27 Mar 2021 05:15:04 -0400
Received: from zn.tnic (p200300ec2f1ad700ac57d777471ee151.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:d700:ac57:d777:471e:e151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4859D1EC0541;
        Sat, 27 Mar 2021 10:15:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616836503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GM3bTHM73MWdbKG6Lj6lq55s4Znce5YscbjHgYvc2gQ=;
        b=iAHPsbLl4rxsPsuKXtFAqkAPls4MMOGdW/MOrshbwicxWZPuW3ushl/owWjA9TdWCOrUzl
        Xs1vQDjCd8vmstlPZt3qmyg302h53tlcro4y4K4fyNOvVNXzYK7BFDAlSxZ3vCTOtXR5GL
        MqPkzyUOMT0RHe73SaP0hNm6OhMIMUo=
Date:   Sat, 27 Mar 2021 10:14:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210327091459.GA16178@zn.tnic>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
 <CAJvTdKm8aQPwQMXFQWgVb5dfJ88ds3d0=uHOyWeueUqfya9Nsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKm8aQPwQMXFQWgVb5dfJ88ds3d0=uHOyWeueUqfya9Nsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 26, 2021 at 11:39:18PM -0400, Len Brown wrote:
> Say a mainline links with a math library that uses AMX without the
> knowledge of the mainline.

What is a "mainline"?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
