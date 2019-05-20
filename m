Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50312243C3
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 00:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfETWzm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 18:55:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35302 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfETWzm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 May 2019 18:55:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id p1so2023572plo.2;
        Mon, 20 May 2019 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BjbgkbeOHTGhsjCy7OuxJHMPPkUmdjz23iAfUR7ljPg=;
        b=HU8isgRW3uguKD67qSirZnoX4T/2EhG93h+rxlkXP9HrUQdNZlN3JzqdO53jOxACQZ
         TpDriJVeoXal6/RRj+iro8d4y7zPjtd81wCOX6ryGb0T7YFUXT4YcH7hKeMxQ/bMNEU5
         uo3j1EWgLO7v17RGewOfi7a3lq70dv/VQTvYaqf8DaM3H/2gi8+4rk6VaoSrPk1tydkC
         LFOis+L8NAFZ/HXut1M1Yh65814eJVhO2rQvRJuMsnS2LuZZQr9aJMFvycEO3o5oBbwE
         WWFn7i54Xv2t8aDBLGQbW9T+w4Nn2kL/1MYzJc2IS0KHkCE2y9YcwDkUPdiZrBmGfKT7
         SXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BjbgkbeOHTGhsjCy7OuxJHMPPkUmdjz23iAfUR7ljPg=;
        b=i/wSWIR9LBAHmzlAUfxRe/GU0wrO5pEXhSVu8z4QSQ4M65Y9+VvJBIzTPzVU8YYJcP
         93445dgF4ZctPIFXkRBauDvVdwcoUS0kWRn/eb5LgMiKcRk09YcrQGsSWgD3ljpoFR6G
         FiWYUThCSsqYDwA9v9oVXxcNxOgo9PPw1/xIhKrqg9+OMIZAorHfqMUgzW2k3GIr0Uo5
         XSpfuG1o5eZXqrV/puey3puCCbtMFg2zo8eJTO5AGXGEHY7uxrIbauKEQhmYdcVdDsfa
         dKUWRmRSFlVHrneQdghWyServ1cOOoz3ekp8Sedd/JI+BJFTAY0JIDn3Y8HEnWQYfGWo
         OA6A==
X-Gm-Message-State: APjAAAVGcYD6zyPolRusG8unlWzTj5/Z6Shfgkaqrr4hIaDzDNdwA50y
        so17RC36AUKatdOdBpE1Ouk=
X-Google-Smtp-Source: APXvYqxJcDWonzZ2CUXr8a8hGMt9fD1MNq+9Q9WdoNmZaquGBn5NDx28goXyWcXD3JYa+LYamNjjvg==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr61953894plb.300.1558392941633;
        Mon, 20 May 2019 15:55:41 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id k3sm25292163pfa.36.2019.05.20.15.55.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 15:55:40 -0700 (PDT)
Date:   Tue, 21 May 2019 07:55:34 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 1/7] mm: introduce MADV_COOL
Message-ID: <20190520225534.GB10039@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-2-minchan@kernel.org>
 <20190520081621.GV6836@dhcp22.suse.cz>
 <20190520081943.GW6836@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520081943.GW6836@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 20, 2019 at 10:19:43AM +0200, Michal Hocko wrote:
> On Mon 20-05-19 10:16:21, Michal Hocko wrote:
> > [CC linux-api]
> > 
> > On Mon 20-05-19 12:52:48, Minchan Kim wrote:
> > > When a process expects no accesses to a certain memory range
> > > it could hint kernel that the pages can be reclaimed
> > > when memory pressure happens but data should be preserved
> > > for future use.  This could reduce workingset eviction so it
> > > ends up increasing performance.
> > > 
> > > This patch introduces the new MADV_COOL hint to madvise(2)
> > > syscall. MADV_COOL can be used by a process to mark a memory range
> > > as not expected to be used in the near future. The hint can help
> > > kernel in deciding which pages to evict early during memory
> > > pressure.
> > 
> > I do not want to start naming fight but MADV_COOL sounds a bit
> > misleading. Everybody thinks his pages are cool ;). Probably MADV_COLD
> > or MADV_DONTNEED_PRESERVE.
> 
> OK, I can see that you have used MADV_COLD for a different mode.
> So this one is effectively a non destructive MADV_FREE alternative
> so MADV_FREE_PRESERVE would sound like a good fit. Your MADV_COLD
> in other patch would then be MADV_DONTNEED_PRESERVE. Right?

Correct.
