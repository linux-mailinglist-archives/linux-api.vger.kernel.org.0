Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4F1638EA
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 02:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgBSBCz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 20:02:55 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39850 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBSBCz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 20:02:55 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so1787091pjr.4;
        Tue, 18 Feb 2020 17:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XjAe17WwACXa462Lft2fmmYSSdsBuO8CjnLHnDQfA9o=;
        b=N/mnf1Er4IIWBp/vNkC29mKZ4xdYtar5T1k0lCH0ra0Gvg4QEsfodG4yfbYjbIIVsA
         Ebxt5L+ceOQDzzgQ6ss86xHtREFi/atw695bOLYoGADEvvUHZWQrOn3GjpxgtI80l4nf
         dgcEwaDoUjgD8cKwpn2DT7SP55f/ZpeuEi9PesGyEYi75Cwkm8OrHffgemLfc21yIrJa
         aoXB10/qxrB2kTMZWy0pY/5Y9GD7DPniS0kC7A0ckCJxB0JvfOXv6RgEuMZymEVkCP3m
         VLplNEJHE/x8lhuA06ehV5xEjMvN7tIlS668+bwte2sjl1f4i9vAGiQlw7iV8BvcOPMa
         B0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XjAe17WwACXa462Lft2fmmYSSdsBuO8CjnLHnDQfA9o=;
        b=IjqTQpagTIHZ8IBpUYnaYhpwn2a8Sr9U2tXcyDyPiYxocO/MZlJY2ARdJ9KRDgvvPO
         yoCucKtljjeYeWtIHLIpPofch6cX0wG+vu3RiiJ2FVdPKJP0TIMCyYMUphmtqwVopUj9
         d8XEopFYCiQqomKj/NZiOdJwlH8DwHyuvZjTwbAeIfYTrMMAUxjN2FYJ+VQxpKqB6WrA
         CO8+Cya4KsXUd13l4CvlM/hKwFyuq8V5qQycfYkM2LtFGXU4hZdEvpSCRqryd0DdkmMg
         GseBH7LRWFIoxrDNAc3TlPxQUElObxRv179Ny0wD7NKzCZbpKE+rFopE8hkcDgorZdLm
         kxXw==
X-Gm-Message-State: APjAAAVEpfikGysjUkFto0NOAa7FNaFomBdlKhdcGpN/WP7g1wnQF6ie
        mT0KOxxn6fLRiV5b2tMI+9c=
X-Google-Smtp-Source: APXvYqw/93b9ec12Bht0Doaq2TFiyyatxu8H8/vw+iAKm+7XIR1dpiYwJce2oS3meL+K6eTrysEwfQ==
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr23061828plr.289.1582074174075;
        Tue, 18 Feb 2020 17:02:54 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id r9sm208768pfl.136.2020.02.18.17.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:02:52 -0800 (PST)
Date:   Tue, 18 Feb 2020 17:02:50 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
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
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v5 4/7] pid: export pidfd_get_pid
Message-ID: <20200219010250.GB126504@google.com>
References: <20200214170520.160271-1-minchan@kernel.org>
 <20200214170520.160271-5-minchan@kernel.org>
 <20200217075940.GA10342@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217075940.GA10342@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Feb 16, 2020 at 11:59:40PM -0800, Christoph Hellwig wrote:
> On Fri, Feb 14, 2020 at 09:05:17AM -0800, Minchan Kim wrote:
> > process_madvise syscall needs pidfd_get_pid function to translate
> > pidfd to pid so this patch exports the function.
> 
> For that it should not need to exported, but then again the actual
> patch doesn't export it anyway, so this is just a commit log issue.
> 
> >  extern struct pid *pidfd_pid(const struct file *file);
> > +extern struct pid *pidfd_get_pid(unsigned int fd);
> 
> ... and there is no need for the extern keyword on prototypes in
> headers.

Will fix new version. Thanks for the review!
