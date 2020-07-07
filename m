Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEDA2168B1
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGGI6w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 04:58:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40707 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgGGI6v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 04:58:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id f2so16314369wrp.7;
        Tue, 07 Jul 2020 01:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p2KKakvKcIBMPs7A15wXqiGUJod4izHac2NRC29BoeY=;
        b=MDH4S47AMz7278CpBIu8PAnelnTJg5bloVDlONZOu1RdtNjCbLfm4zpdYm2se/F8hb
         /jtAxQkTrRa2OZHv3vV+M3Sp/4fYQfbcvzsBrpN+p/MLXO+5aVrPw6OgemdsccRohBDD
         3Aj3yyxWC1PFl8jakN7hP6LGs02dzJDkVWo+LlS4SMPi5/pA0rydMgPvDmtZZFgJlOVO
         VMSnCnxDDmQ31OcSUJ+sWMvaNx6zFc3mp4u8RSp3qe8cnjP3G/05EBhYNPagyFPa4epF
         fJ4OiQ3JTpZTi92hWM5vnCam5yIE/lbmB+JL46WIBRzABS7C47/ab+3kg1pWWXQew1i+
         HAYA==
X-Gm-Message-State: AOAM533YYOFUsnNzdNE3RgW7+1O2ZdwvP0fYkibwabaewm2pZjDxVNgC
        rgoPq+DJwkl0u4bcGuMaHVE=
X-Google-Smtp-Source: ABdhPJwh9XUbUNDBRq8RVH5mZ3inft6fVxiv+AyB+oFzHzHwbX6vqWzzuu2czS9FjeuVL6nNGIn0OA==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr52819103wra.348.1594112329520;
        Tue, 07 Jul 2020 01:58:49 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id v5sm192665wmh.12.2020.07.07.01.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:58:48 -0700 (PDT)
Date:   Tue, 7 Jul 2020 10:58:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jann Horn <jannh@google.com>,
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
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Message-ID: <20200707085847.GA5913@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
 <20200707073823.GA3820@dhcp22.suse.cz>
 <20200707080726.GA32357@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707080726.GA32357@amd>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 07-07-20 10:07:26, Pavel Machek wrote:
> Hi!
> 
> > > > > This patch adds logic to the kernel power code to zero out contents of
> > > > > all MADV_WIPEONSUSPEND VMAs present in the system during its transition
> > > > > to any suspend state equal or greater/deeper than Suspend-to-memory,
> > > > > known as S3.
> > > >
> > > > How does the application learn that its memory got wiped? S2disk is an
> > > > async operation and it can happen at any time during the task execution.
> > > > So how does the application work to prevent from corrupted state - e.g.
> > > > when suspended between two memory loads?
> > > 
> > > You can do it seqlock-style, kind of - you reserve the first byte of
> > > the page or so as a "is this page initialized" marker, and after every
> > > read from the page, you do a compiler barrier and check whether that
> > > byte has been cleared.
> > 
> > This is certainly possible yet wery awkwar interface to use IMHO.
> > MADV_EXTERNALY_VOLATILE would express the actual semantic much better.
> > I might not still understand the expected usecase but if the target
> > application has to be changed anyway then why not simply use a
> > transparent and proper signaling mechanism like poll on a fd. That
> 
> The goal is to have cryprographically-safe get_random_number() with 0
> syscalls.
> 
> You'd need to do:
> 
>    if (!poll(did_i_migrate)) {
>          use_prng_seed();
> 	 if (poll(did_i_migrate)) {
> 	       /* oops_they_migrated_me_in_middle_of_computation,
>  	          lets_redo_it() */
>  		  goto retry:
> 	 }
>    }
> 
> Which means two syscalls..

Is this a real problem though? Do we have any actual numbers? E.g. how
often does the migration happen so that 2 syscalls would be visible in
actual workloads?
-- 
Michal Hocko
SUSE Labs
