Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55E9216797
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 09:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgGGHkk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 03:40:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53874 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGGHkk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 03:40:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id j18so42199390wmi.3;
        Tue, 07 Jul 2020 00:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mkLi5/2cSGgCl/orCCI+WQ6ij4dPXxM5S2mGX3t0dbo=;
        b=tOdMgp7oosoRMPvPal5+ijzSdJr72YZjuHPeP7s70V+aRUs/BbauzLPXZWYol5aaEs
         nIuHj4tp4+Cpd6HmY57o9ur9cXKDr32HkjTswKL460D3kzdrrEIs0hzd3bvsV+KN6hS7
         IQfJYGlP1z7va4N207Ooip2Cyn7HRugQlo5jrZHdM69rr1DUY/8wlwdQmUyxRL8lMGLk
         GZt1M5LPLCBdW3xWAMoTXlw/VbsC+zNRJuqIvaYBdQ+Qcq2VjZrw6INnoBTCs5LVWMcl
         SB+pcxwBAuEs7eYQjkZJOn+3IKaxyQWsZKqfs8/TX/0EldnCYtjF2JMqsTWIXDn0msW9
         BTgw==
X-Gm-Message-State: AOAM533qyvG+I+HAuo6bqkAKL5tXl8RaJ8+8BHiGfUhdono1W9DEV6lW
        z9uSRdrH91W6nR/6QYszBWM=
X-Google-Smtp-Source: ABdhPJxZJEUdcW0X69/BdwNsvMtSqC0D3HaxiNuMfjIEkWNL/6j1aTh84oerAukVLXiZeh7bk3rWtA==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr2639851wmn.167.1594107638192;
        Tue, 07 Jul 2020 00:40:38 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id e23sm2189282wme.35.2020.07.07.00.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 00:40:37 -0700 (PDT)
Date:   Tue, 7 Jul 2020 09:40:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Colm =?iso-8859-1?Q?MacC=E1rthaigh?= <colmmacc@amazon.com>
Cc:     "Catangiu, Adrian Costin" <acatan@amazon.com>, linux-mm@kvack.org,
        linux-pm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        fweimer@redhat.com, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, mingo@kernel.org, bonzini@gnu.org,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Message-ID: <20200707074036.GB3820@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <BC9E44B2-D3C2-43C7-8F4B-A31477147368@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC9E44B2-D3C2-43C7-8F4B-A31477147368@amazon.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 03-07-20 18:45:06, Colm MacCárthaigh wrote:
> 
> 
> On 3 Jul 2020, at 4:30, Michal Hocko wrote:
> 
> > On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
> > > This patch adds logic to the kernel power code to zero out contents
> > > of
> > > all MADV_WIPEONSUSPEND VMAs present in the system during its
> > > transition
> > > to any suspend state equal or greater/deeper than Suspend-to-memory,
> > > known as S3.
> > 
> > How does the application learn that its memory got wiped? S2disk is an
> > async operation and it can happen at any time during the task execution.
> > So how does the application work to prevent from corrupted state - e.g.
> > when suspended between two memory loads?
> 
> The usual trick when using MADV_WIPEONFORK, or BSD’s MAP_INHERIT_ZERO, is to
> store a guard variable in the page and to check the variable any time that
> random data is generated.

Well, MADV_WIPEONFORK is a completely different beast because the
forking is under a full control of the parent process and the
information about the fork can be forwarded to child process. It is
not like the child would reborn into a new world in the middle of the
execution.

-- 
Michal Hocko
SUSE Labs
