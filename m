Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A522515C923
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 18:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBMRIP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 12:08:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46857 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgBMRIP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 12:08:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so3355615pfp.13;
        Thu, 13 Feb 2020 09:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cwmRNtTZcXSptayyAZBxEOQV5KhhsA6UhdxP7QWveJ0=;
        b=UUykb+RLyTck9we2hEU+HBlutDbVy5OAj/ybxhRnEXujdklsJACVx/5Bgzj2CIEvFh
         8uARFfH7gvW307v1lAK31+4dKBWgeov5dV+2DC3hcwMCux3xoZzO+7qkY+1S7z6f8Ar+
         ioO23mzmBHDtV7B7NcDxCEdledp/TEqBwltKjTjf7GB6O+or932lqR869R+iU8U211SK
         ApibpKxMygqKsHNrSByn4fGnFI5uwHhohjc6h974ozA058lhgpLTJF193DoVsAZ5oHSG
         ES+gAxmvaqwfxBEJRz3jOItZ2VWiiQKKBr8EKC4yiI5CUPzSmVIG/pz8TBPQuYbM29Ut
         cerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cwmRNtTZcXSptayyAZBxEOQV5KhhsA6UhdxP7QWveJ0=;
        b=Xq7s0ebwMfF9N9ukSVwig9Fpeo8enINpVrthFySORQNeh1nVEoNVnnkJf83eAC5Jav
         drSwvnW9gySJ2NrdMI0LKXt++dXlaiZKBmCiQBmZWOjkIINK6xmaVlSJ9SWzkcV1reHt
         lx96/QC/rVr+AC1yaXd/Oq/llsOawVQnephcq0wlg2FmQDNn3JHRMaRg5s7C6WdlwG0s
         sQ65wnwtuh3TNquPKfL1jzB8KJGBdapmo+6NGrf3I5B75GS5d0/FYTQdEndyBfrPIT+B
         AKLFXcd9iAyMhqsDv/HIcUDiGoo2NCXAXCig9ccJkuj+SmkQnsoNbEG6nXMyVnGGXI4F
         0HPg==
X-Gm-Message-State: APjAAAVmWzCnvuLP9n7WIz4dCdk2qEB9570ZCUg2IlEcwkeMrL1fMoPn
        hiRRWCJCQUPhVZAtOQT2j7o=
X-Google-Smtp-Source: APXvYqwuN/CZ5krfQve1Eey7OtDNyhFPTJrkJ7ZHF49IJ3Nf44GFnVB0IqN9DxlY22aJ29W3O9ZPUA==
X-Received: by 2002:aa7:96b7:: with SMTP id g23mr14384130pfk.108.1581613694659;
        Thu, 13 Feb 2020 09:08:14 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id 64sm3836195pfd.48.2020.02.13.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:08:13 -0800 (PST)
Date:   Thu, 13 Feb 2020 09:08:11 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v4 7/8] pid: export pidfd_get_pid
Message-ID: <20200213170811.GA41717@google.com>
References: <20200212233946.246210-1-minchan@kernel.org>
 <20200212233946.246210-8-minchan@kernel.org>
 <6bb20b3d4e3362337e1a4c8a4be13f6acda5b0ec.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb20b3d4e3362337e1a4c8a4be13f6acda5b0ec.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Alexander,

On Wed, Feb 12, 2020 at 04:25:31PM -0800, Alexander Duyck wrote:
> On Wed, 2020-02-12 at 15:39 -0800, Minchan Kim wrote:
> > process_madvise syscall needs pidfd_get_pid function to translate
> > pidfd to pid so this patch exports the function.
> > 
> > Cc: Christian Brauner <christian@brauner.io>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> I think you might have misunderstood my earlier comments. This should be
> patch 2 in your set. What is patch 8 should be folded into you existing
> patch 2 and become patch 3 with the rest of your patches shifted by 1
> since you are reordering them.
> 
> Otherwise the code itself appears to not have changed anything so it looks
> fine to me.
> 
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

It was my intention because I expect supporting both pid and pidfd would be
controversial. It would make easy to revert.

Thanks for the review!
