Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B429D34D440
	for <lists+linux-api@lfdr.de>; Mon, 29 Mar 2021 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhC2PsF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Mar 2021 11:48:05 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:37679 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhC2Pry (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Mar 2021 11:47:54 -0400
Received: by mail-ed1-f41.google.com with SMTP id x21so14763875eds.4;
        Mon, 29 Mar 2021 08:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhGp0qCEbGMGV56oXQiQ4QElYxInA3LXi3gdMNA56qk=;
        b=hjt7FQwlFeDhtE+KCKjjy5h2EpLjNN77xgp5glF0UxRIjVYaSplbVKRnkACcB1Ef/y
         Jmh3o43y7u5+YNRJB1TPaExdMg/IEFUrf5tKYThJxvlbOIamU2p8Fa9xCjVchEL4chT1
         UDhCbqTS5wppJWOp4fukGS82rcT43SW8Ia8n1LCyS9t1o9/BNRtr/oEQVXckM5hforcs
         5H18Hhh/9tM7VfvVqdekZttpvHb2a1ruX6Z2dOiHJC9WiTNmCH3OSPCBEbDyVk08cRrA
         iJJFd4N88gul7rRicGo5ZC0vzHmWnUks+aEnrGDI5ZH1rDZ3EQedxSqA7GwSQN/rB5jT
         llZA==
X-Gm-Message-State: AOAM53335Em1aV/yNansJT30Tuyri/Z0ANrOT3Iv9YiVQtI+hgj2b17s
        mRp1519BPm0ibkDILnqAwA7/zYzH++b+bMtmtrc=
X-Google-Smtp-Source: ABdhPJyG2uP+iHS4uMVz+cKJvv52tKkpzAeKEInq3ctU7mOsBtvAphumaazoXwgIXWElU0oyD4uhtPqwShCPtgfgZ1Q=
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr29232689edy.310.1617032873137;
 Mon, 29 Mar 2021 08:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
 <CAJvTdKm8aQPwQMXFQWgVb5dfJ88ds3d0=uHOyWeueUqfya9Nsw@mail.gmail.com> <YF8B3M9qihZzCf3n@kroah.com>
In-Reply-To: <YF8B3M9qihZzCf3n@kroah.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 29 Mar 2021 11:47:42 -0400
Message-ID: <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
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

On Sat, Mar 27, 2021 at 5:58 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 26, 2021 at 11:39:18PM -0400, Len Brown wrote:
> > Hi Andy,
> >
> > Say a mainline links with a math library that uses AMX without the
> > knowledge of the mainline.

sorry for the confusion.

mainline = main().

ie. the part of the program written by you, and not the library you linked with.

In particular, the library may use instructions that main() doesn't know exist.

-- 
Len Brown, Intel Open Source Technology Center
