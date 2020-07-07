Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801FA2167A2
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 09:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgGGHo3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 03:44:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51665 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGHo3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 03:44:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so42219276wmg.1;
        Tue, 07 Jul 2020 00:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F4aqx7HxhCSSKHXwc2697sIHhQdT/BBdsfLF62DEQE4=;
        b=ptO3vsQ6wFvagw+FxNAxlLeKHzc3hnxlPhivKE7lybGb5boGg9YnHixKorIH1VB2gN
         JJONw+i9p8RuPqmN2/zTET0x1NEx7rG5zwEcqtC9R75xkxWV/jas+2TRwLev+altPE+M
         oIjOf31fAOxF0KWBEIKxhDW/xwXzld43cvCYpURoXj9I7yBSnw39Wvf6Gt2om0HeSWIi
         fQq29/IIZkXNlxuXiT5NzNBDNznN4FbtTHnN3Pf3rA2Z4yOaB1C/+Mo8fxm0NSai0Mnp
         GbXZ1PxhHRrAn4tgBke/F/XlsrgyqfeJ0ZafAoG54kT4iJbe+qM1H9pZF4lAqWBLDm/1
         VbYg==
X-Gm-Message-State: AOAM533otHzYsu2Vz0pbnXz+wF2ROhRr5V303csKNtznGTAWTNmWYfhL
        5SWK8PF21GFaniPTnfoUbXE=
X-Google-Smtp-Source: ABdhPJx+I2TIfUFvZS7RzpHU0dX1TjZmj/O3FD7sf6peHipy/sldWFpAe42dJn2scLZ0GHRhPo4TxQ==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr2950573wmi.114.1594107867373;
        Tue, 07 Jul 2020 00:44:27 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id q7sm15968740wra.56.2020.07.07.00.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 00:44:26 -0700 (PDT)
Date:   Tue, 7 Jul 2020 09:44:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Alexander Graf <graf@amazon.com>, Pavel Machek <pavel@ucw.cz>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Message-ID: <20200707074425.GC3820@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703224411.GC25072@amd>
 <CAG48ez0oWQd42a-H-Dzw1Wq7HgB5PpFRGCZeYxP8ohxaoZHmvQ@mail.gmail.com>
 <20200704114820.GA16083@amd>
 <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
 <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 06-07-20 14:52:07, Jann Horn wrote:
> On Mon, Jul 6, 2020 at 2:27 PM Alexander Graf <graf@amazon.com> wrote:
> > Unless we create a vsyscall that returns both the PID as well as the
> > epoch and thus handles fork *and* suspend. I need to think about this a
> > bit more :).
> 
> You can't reliably detect forking by checking the PID if it is
> possible for multiple forks to be chained before the reuse check runs:
> 
>  - pid 1000 remembers its PID
>  - pid 1000 forks, creating child pid 1001
>  - pid 1000 exits and is waited on by init
>  - the pid allocator wraps around
>  - pid 1001 forks, creating child pid 1000
>  - child with pid 1000 tries to check for forking, determines that its
> PID is 1000, and concludes that it is still the original process

I must be really missing something here because I really fail to see why
there has to be something new even invented. Sure, checking for pid is
certainly a suboptimal solution because pids are terrible tokens to work
with. We do have a concept of file descriptors which a much better and
supports signaling. There is a clear source of the signal IIUC
(migration) and there are consumers to act upon that (e.g. crypto
backends). So what does really prevent to use a standard signal delivery
over fd for this usecase?
-- 
Michal Hocko
SUSE Labs
