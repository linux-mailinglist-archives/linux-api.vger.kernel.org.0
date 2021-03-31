Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3111F3509F8
	for <lists+linux-api@lfdr.de>; Thu,  1 Apr 2021 00:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhCaWMD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 18:12:03 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45944 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCaWLn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Mar 2021 18:11:43 -0400
Received: by mail-ed1-f43.google.com with SMTP id bx7so24039986edb.12;
        Wed, 31 Mar 2021 15:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2axwWxTL8XPpHwUo4AVE1zruv6RF5CEAUfc387i7Es=;
        b=MUI0Rz04kwGUZSu+DD2JrZWSaRabmNc/h+GGyp1XexmOj+wEsIcAdM8A67S+1imDCS
         kiVK1AOWbMbd8SuUWhYz1SxwIqVKlQ/7ckQcYZhOMjIHuDX9bAjW+wxidKwnWAxLuJSB
         NkBXnRflmSUurzuUbBj2KicF/RqRU/pTZbpiRwlVGMa3w3lLozyMjAZqlKmicxrlQkde
         Pa4n8hU8XwbmDsspTSyLgTtg9xoDCF5jHjUGVWRydXprvtf78azBam8KHlPj9bdXfTB8
         FKw1MI+VRr8mm1snJpYua2PtYd2R+SVdy/XCLCAnRD64425mZNlcvKmPJH/3rfHpdtWI
         S97Q==
X-Gm-Message-State: AOAM532OOaE/8sWvLyBAXmoDcxDfvNo7lwWCP4yBRrxE71GU33epAl6y
        KzhsPMUOySEH8WxWbIQdPD8wTYZ42D2afpFRnug=
X-Google-Smtp-Source: ABdhPJxF0AoPasiOPUQ+0kRTOZRzhmrm9mBUogAT7SW0kIY9/mhNKnb1B9vGVs2u4pcp4dvBgMyrOrOTNlzbCilvdZs=
X-Received: by 2002:aa7:d917:: with SMTP id a23mr6430206edr.122.1617228702378;
 Wed, 31 Mar 2021 15:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net> <CAOp6jLb6OwfaBcYsdRZ-A5FLpY+y7WNoBqwc+2oCP7-3Sy-ZHg@mail.gmail.com>
In-Reply-To: <CAOp6jLb6OwfaBcYsdRZ-A5FLpY+y7WNoBqwc+2oCP7-3Sy-ZHg@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 31 Mar 2021 18:11:31 -0400
Message-ID: <CAJvTdKkYPK2iqUPGMQZ63Qdgfy_JR5fpjQevcwJZ0Y+PHM80Cw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     robert@ocallahan.org
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

On Wed, Mar 31, 2021 at 5:42 PM Robert O'Callahan <robert@ocallahan.org> wrote:
>
> For the record, the benefits of dynamic XCR0 for rr recording
> portability still apply. I guess it'd be useful for CRIU too. We would
> also benefit from anything that incentivizes increased support for
> CPUID faulting.

As previously mentioned, today we don't have an architectural way to
trap a user into the kernel on CPUID,
even though we can do this for a VMM.

But spoofing CPUID isn't a solution to all problems.
The feature really needs to be OFF to prevent users from using it,
even if the supported mechanisms of discovering that feature say "NOT PRESENT".

Today there are plenty of users who will opportunistically try everything
in the cloud and choose the machine that allows them to do something
that other machines will not -- even if it is not officially supported.

If something is not enumerated, it really needs to also be turned off.

cheers,
--Len Brown, Intel Open Source Technology Center
