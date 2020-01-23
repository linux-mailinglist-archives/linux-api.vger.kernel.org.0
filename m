Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22759146089
	for <lists+linux-api@lfdr.de>; Thu, 23 Jan 2020 02:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAWBnU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Jan 2020 20:43:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55983 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgAWBnU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Jan 2020 20:43:20 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so417234pjz.5;
        Wed, 22 Jan 2020 17:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nA4RMqX5haJ1ua8Yhgc4HIMDyOGoyPdaKIKHYrYlVmk=;
        b=BhHdW1DPSWyzW2/+yWG5oEft9hG4f7HTQrTpV1jtz96GioQx6Jnb4tHm5qGNgoDSVH
         uYpR1N7Tc+PiZNplBbA1oCeZ0OiTJK0J++qRoXnOg3SricR9U9+ZE73Cd3IIYhGdpWF6
         8Bl7Z0CXf2tb0hOow02SnKKKEOloD270mzLEUYrs6LLI1PELah9c9bWMUSDtOMUVF97R
         NsUjuCSfOjnthdeM3+o2NzmzpRSBq+8qaxwXf/HhrFmrE89nm+btgUWZWPRfjWX5M2ZF
         /9O3yUQ/8jVHBXLs9vG+yYqki6/hf1T1Q3ilAel8jdza6GzUuCdtx7fWp/To/d+2veBK
         uKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nA4RMqX5haJ1ua8Yhgc4HIMDyOGoyPdaKIKHYrYlVmk=;
        b=FwhSSun40VVCHTKi4lzHGP43G95m75+5hX3855agWziLyazpkoFBwUu4qSvx7BPlob
         QciJq2DaT2VzkgRhSj9iG5ESfhdWwWLmJBsu/Y5KH5nLHh7gePiDwyEm+x5fsaVG6JoD
         RE9YXy/J8hsd/hLX1zdi2uXpYs5/6GUg+kde+c1jou2NpHYTn00NWJf+/vrQA3+vK8ZF
         tEJPfZ09tON/eMnTipTWQPmfLwTNdkxtikDkHkbzuT/lE7DjA28xQdjvljq4ky5df66z
         iIPhH9Sy1sock1J5iH4gBsLGG2aimWWGD4VSBA1kJsJFSQfk/Ynf7mdk5iESWY3QxJo8
         P1Hg==
X-Gm-Message-State: APjAAAUvx7Sh0nGWSJOa/ymLBJyFE/AdPEiSaGYOWtz+pNl7XgRtAMJp
        KS8k7G71zeDK5CwCkZWddYAMyHDw
X-Google-Smtp-Source: APXvYqzq1S4H4X9XLJt3DcWAS97wjkB2xs3kqJ7LItoh0aaUXnndPh+1V3NJYWlsEx82aRhUkp6bBw==
X-Received: by 2002:a17:90a:300b:: with SMTP id g11mr1583571pjb.123.1579743799340;
        Wed, 22 Jan 2020 17:43:19 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id j17sm199787pfa.28.2020.01.22.17.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 17:43:18 -0800 (PST)
Date:   Wed, 22 Jan 2020 17:43:16 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200123014316.GB249784@google.com>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
 <20200121181113.GE140922@google.com>
 <20200122104424.7gvrfivymjvdous4@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122104424.7gvrfivymjvdous4@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jan 22, 2020 at 11:44:24AM +0100, Oleksandr Natalenko wrote:
> Hello.
> 
> On Tue, Jan 21, 2020 at 10:11:13AM -0800, Minchan Kim wrote:
> > > > I also think people don't want to give an KSM hint to non-mergeable area.
> > > 
> > > And how the manager knows which data is mergable?
> > 
> > Oleksandr, could you say your thought why you need address range based
> > API?
> 
> It seems I've overlooked an important piece of this submission: one
> cannot apply the hint to all the anonymous mapping regardless of address
> range. For KSM I'd rather either have a possibility to hint all the
> anonymous mappings, or, as it was suggested previously, be able to iterate
> over existing mappings using some (fd-based?) API.

Thing is how you could identify a certan range is better for KSM than
others from external process?
