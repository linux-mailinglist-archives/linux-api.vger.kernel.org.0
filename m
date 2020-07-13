Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A921D147
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2020 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgGMICM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jul 2020 04:02:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45578 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgGMICK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jul 2020 04:02:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id d16so12240372edz.12;
        Mon, 13 Jul 2020 01:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QIHoei67Z3/KR3sFEx7o/EA6f6Nm5nK1Sv4SUBIKxAE=;
        b=uWtr2NtA5esiQAeZzXzZ29nm2HqsBEYic/Njm/2Ibrh8zWfYaUNNT1gWb0X66Ut2wk
         j6OaMi6YpkGb1EQRXjx45O9a+Az5rdAn1w2yDuVV0rabAOTmv9Fw6zqkiQcNgdyRh+hC
         E9LpBAlVP0mZITHk4nmmTm64s/5/dGnngPHvrKLFTSXRGblY0JvlsPR1IjvU4gFkS/Rl
         hHylpKMefu4ZIr21PEnIzZt2socKiVyBWsiIhy88sIM6T8Jzd4igeOHD8lrOiaewgd1T
         0Bn+iiXKob0wzxdiwP3YSupQl8gKNbwSBo00jom38tXadg9nPu3pXRrgfs4qsp7StBP3
         2VBA==
X-Gm-Message-State: AOAM533B83BudJzbJYbTZ0yPdGlTNkVp+hIVfNaO7qnLbVpsNMpVZXxs
        m882/tn2PG+tXWNv1ZzsIx0=
X-Google-Smtp-Source: ABdhPJwWvN1QcpCsa31iIwBgYb5oydvR6pwx8KYoNceT/279HJ9gdKt0l1YifwXe/09Udr1Sulcp2A==
X-Received: by 2002:a05:6402:1c07:: with SMTP id ck7mr78270857edb.297.1594627328559;
        Mon, 13 Jul 2020 01:02:08 -0700 (PDT)
Received: from localhost (ip-37-188-148-171.eurotel.cz. [37.188.148.171])
        by smtp.gmail.com with ESMTPSA id cw19sm9155356ejb.39.2020.07.13.01.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:02:07 -0700 (PDT)
Date:   Mon, 13 Jul 2020 10:02:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Colm MacCarthaigh <colmmacc@amazon.com>,
        Jann Horn <jannh@google.com>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>, linux-mm@kvack.org,
        linux-pm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        rjw@rjwysocki.net, len.brown@intel.com, fweimer@redhat.com,
        keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        mingo@kernel.org, bonzini@gnu.org,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Message-ID: <20200713080206.GD16783@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
 <20200707073823.GA3820@dhcp22.suse.cz>
 <20200707080726.GA32357@amd>
 <20200707085847.GA5913@dhcp22.suse.cz>
 <20200707163758.GA1947@amd>
 <E6B41570-E206-4458-921B-465B9EF74949@amazon.com>
 <20200712072228.GB4721@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712072228.GB4721@duo.ucw.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun 12-07-20 09:22:28, Pavel Machek wrote:
> On Tue 2020-07-07 12:00:41, Colm MacCarthaigh wrote:
> > 
> > 
> > On 7 Jul 2020, at 9:37, Pavel Machek wrote:
> > > Please go through the thread and try to understand it.
> > > 
> > > You'd need syscalls per get_randomness(), not per migration.
> > 
> > I think one check per get_randomness() is sufficient, though putting it at
> > the end of the critical section rather than the beginning helps.
> 
> Yeah, well, one syscall is still enough to make it useless.

I am sorry but I really do not follow. Why would you want to call a
syscall on each get_randomness invocation? Why is it not enough to
simply have a flag that tells that an external event has happened
and reinitialize if the flag is set? Yes this wouldn't be really sync
operation but does that matter? Is using a few random numbers from the
old pool just because the notifier hasn't processed and flag the
situation a major security concern?

Btw. let me just clarify that I am not by any means pushing a solution
like that. All I am saying is that MADV_WIPEONSUSPEND is inherently
subtle interface that we likely want to avoid.
-- 
Michal Hocko
SUSE Labs
