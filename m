Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1996C21678D
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgGGHi2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 03:38:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39102 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGGHi1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 03:38:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id w3so32935791wmi.4;
        Tue, 07 Jul 2020 00:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ikBOfPiAYjEtvfpg2ndBX1AEFGTwRae8CH9t1jZQyN4=;
        b=nFgXFCY1FM/1lZloRMvDmmVZ06n76XaYa5PNNjqdL2oCqTE1PvRWbFRXcxqmW+c0T+
         5ka1L/qFuL59glCsl/uNJJRrKQxZkJ7Fg9W8Bag/1j1M0qVm+xQRDv/wY0RCt0o1aP9Y
         OVe2ZzAagEMYq5Hz7R+kLBP8lmnNTrVJx5qo/6MX6HOyM2UuecGGF57n/8FHRxoOvkUt
         AOENSQ8MNQt8RYFi+1CpJMJJ4Ks5WVmqY2CY2+kac+L6H68LtmWxCjbBfA4S6Ws5PsK3
         Seuwbff6jndvPedsiDXEBxUHbhZ319dMjrGzVGOOIlwnS/bFAnWj4dYWcyuNJ3+AYSDJ
         MtWQ==
X-Gm-Message-State: AOAM532dFM+NwH+zfW2p3kuG6LqwwZQ+2aR+RSJhPAgkXFSDVzrro3sp
        qem2ABX8T8+C29jwbsM3tRw=
X-Google-Smtp-Source: ABdhPJw+rfkXNBOmAmzmsHQwYBliQFLIQ5OnnLWSGUd52iK1yN+tLiulM3nr1g/sS85KQZxjR0w1Lg==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr2750285wma.88.1594107505827;
        Tue, 07 Jul 2020 00:38:25 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id 33sm28857100wri.16.2020.07.07.00.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 00:38:24 -0700 (PDT)
Date:   Tue, 7 Jul 2020 09:38:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Message-ID: <20200707073823.GA3820@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 03-07-20 15:29:22, Jann Horn wrote:
> On Fri, Jul 3, 2020 at 1:30 PM Michal Hocko <mhocko@kernel.org> wrote:
> > On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
> > > This patch adds logic to the kernel power code to zero out contents of
> > > all MADV_WIPEONSUSPEND VMAs present in the system during its transition
> > > to any suspend state equal or greater/deeper than Suspend-to-memory,
> > > known as S3.
> >
> > How does the application learn that its memory got wiped? S2disk is an
> > async operation and it can happen at any time during the task execution.
> > So how does the application work to prevent from corrupted state - e.g.
> > when suspended between two memory loads?
> 
> You can do it seqlock-style, kind of - you reserve the first byte of
> the page or so as a "is this page initialized" marker, and after every
> read from the page, you do a compiler barrier and check whether that
> byte has been cleared.

This is certainly possible yet wery awkwar interface to use IMHO.
MADV_EXTERNALY_VOLATILE would express the actual semantic much better.
I might not still understand the expected usecase but if the target
application has to be changed anyway then why not simply use a
transparent and proper signaling mechanism like poll on a fd. That would
be certainly a more natural and less error prone programming interface.

-- 
Michal Hocko
SUSE Labs
