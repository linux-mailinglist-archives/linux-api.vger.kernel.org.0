Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E8F58E58
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2019 01:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF0XMT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 19:12:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41077 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0XMT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Jun 2019 19:12:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so1954961pff.8;
        Thu, 27 Jun 2019 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3K8ZEEArtsKiEJ5I7k4SQLYx/luEOe5+arx+qBgdSFA=;
        b=JSk4HdvqruT+eRFKcMzKF4cuqUMKAFW0JmLoEPitz4V9TYrtKEJX4lFAYbPrn+53Sr
         iScOFwvbVbYQmM0y8f/WY1EJOSMQYHxuToZnJjChnKzKTZFqMoTt5HBG3WLdxnDjc38m
         a64MaJrlM59WDcPpUi603vXqz1z5jxeJIA6WVnx3wdmiGFtIrrhJJl0wbw+/zI2tItVS
         2WFm+5OmdgiY+zckFV8E0k+HtY/mr56quNTtxkI5cjogi4SpVGiwHjZQIAKP68nearBn
         gle5TBra9FVnkjUV0vdkG42M04Pu3Ydc95ZQLipUDBCMbx1qIczM3Mj5HCiYQLeXM6f9
         0MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3K8ZEEArtsKiEJ5I7k4SQLYx/luEOe5+arx+qBgdSFA=;
        b=dqTmYBxcxHZ3QOzzGlwdn1TXgGiVcQo5y+F7c67rFTgA1fhgR5CfsNUgIIx/Hbxgpd
         C78ql09hQjwv9qU9UoR7RxgWZFM3XEHHOwJGYEERZKa/5hPaomo6jC1nvsCcP7hGE3bM
         nOEGx/0jFeOJhpOBuZ5NDKps0hpToy8+rFkF6Y0o7yKEIkQlS58czQyHlGM/rRRDmXhk
         4fdUpwc3MvoTmkuvV11c5KAnJ6KkDa5qUnhA6tO5YsPqIoGhyMBaxj6DMZnTCqkSnOSa
         I0qLLeHoQvS6/wo2lbW1x1X3YB2kax6RJUfZzBReP724hwm/J6mnVjiM+f3oAWuYisSB
         FU1A==
X-Gm-Message-State: APjAAAUeOpYRZ+vm799m3jtBCn6RqDnyG/mgf53+COc51n5ND2DystiT
        1Hh3VwL+gPj8zuuCNL0nz2k=
X-Google-Smtp-Source: APXvYqxtn9cf+kC5zwOASaw1d/Oo8w/GiSK/V2r2g0NRoYK4Nj3w5dEEjSiS3BxhR2Cs1b8xLtShlA==
X-Received: by 2002:a17:90a:fa18:: with SMTP id cm24mr8869128pjb.120.1561677138694;
        Thu, 27 Jun 2019 16:12:18 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id x23sm154864pfo.112.2019.06.27.16.12.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:12:17 -0700 (PDT)
Date:   Fri, 28 Jun 2019 08:12:11 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190627231211.GA33052@google.com>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627180601.xcppuzia3gk57lq2@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627180601.xcppuzia3gk57lq2@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 27, 2019 at 09:06:01PM +0300, Kirill A. Shutemov wrote:
> On Thu, Jun 27, 2019 at 08:54:00PM +0900, Minchan Kim wrote:
> > - Problem
> > 
> > Naturally, cached apps were dominant consumers of memory on the system.
> > However, they were not significant consumers of swap even though they are
> > good candidate for swap. Under investigation, swapping out only begins
> > once the low zone watermark is hit and kswapd wakes up, but the overall
> > allocation rate in the system might trip lmkd thresholds and cause a cached
> > process to be killed(we measured performance swapping out vs. zapping the
> > memory by killing a process. Unsurprisingly, zapping is 10x times faster
> > even though we use zram which is much faster than real storage) so kill
> > from lmkd will often satisfy the high zone watermark, resulting in very
> > few pages actually being moved to swap.
> 
> Maybe we should look if we do The Right Thing™ at system-wide level before
> introducing new API? How changing swappiness affects your workloads? What
> is swappiness value in your setup?

It was 100. Even, I tried 150 and 200 with simple hack of swappiness.
However, it caused too excessive swpout.

Anyway, systen-level tune is generally good but if process has hint, that
should work better and that's why advise API is.
