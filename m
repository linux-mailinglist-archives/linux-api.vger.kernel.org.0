Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4AA34B5DF
	for <lists+linux-api@lfdr.de>; Sat, 27 Mar 2021 10:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhC0J7D (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 27 Mar 2021 05:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhC0J64 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 27 Mar 2021 05:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3366161937;
        Sat, 27 Mar 2021 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616839136;
        bh=DJd8AHuqiwkd9UjUyvaudeysMMHVMYfIxkNtuJE78Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3sdHRJWLIvIKvTfFt5hjrxtmsGjZQG1JAb55FshkzIC6pCZArveZ635mR2J2LxzU
         lCPK2rfLhLBih3BZ+JfxveaSg3Wkh+R7FfoRLh/GOFiqOKPX30ILWO8wAldm8JYFZT
         YvsNSAc+gigS1VVWzMhBMGSz4uSXuYAutrqHhTHg=
Date:   Sat, 27 Mar 2021 10:58:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <YF8B3M9qihZzCf3n@kroah.com>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
 <CAJvTdKm8aQPwQMXFQWgVb5dfJ88ds3d0=uHOyWeueUqfya9Nsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvTdKm8aQPwQMXFQWgVb5dfJ88ds3d0=uHOyWeueUqfya9Nsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 26, 2021 at 11:39:18PM -0400, Len Brown wrote:
> Hi Andy,
> 
> Say a mainline links with a math library that uses AMX without the
> knowledge of the mainline.

What does this mean?  What happened to the context here?

> Say the mainline is also linked with a userspace threading library
> that thinks it has a concept of XSAVE area size.

How can the kernel (what I think you mean by "mainline" here) be linked
with a userspace library at all?

> Wouldn't the change in XCR0, resulting in XSAVE size change, risk
> confusing the threading library?

Shouldn't that be the job of the kernel and not userspace?

totally confused,

greg k-h
