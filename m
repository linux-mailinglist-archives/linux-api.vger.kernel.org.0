Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E484CC66
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2019 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfFTKzS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 06:55:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfFTKzS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 20 Jun 2019 06:55:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03F8AAD12;
        Thu, 20 Jun 2019 10:55:16 +0000 (UTC)
Date:   Thu, 20 Jun 2019 12:55:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190620105515.GE12083@dhcp22.suse.cz>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190610111252.239156-5-minchan@kernel.org>
 <20190619132450.GQ2968@dhcp22.suse.cz>
 <20190620041620.GB105727@google.com>
 <20190620070444.GB12083@dhcp22.suse.cz>
 <20190620084040.GD105727@google.com>
 <20190620092209.GD12083@dhcp22.suse.cz>
 <20190620103215.GF105727@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620103215.GF105727@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 20-06-19 19:32:15, Minchan Kim wrote:
[...]
> Then, okay, I will add can_do_mincore similar check for the MADV_PAGEOUT syscall
> if others have different ideas.

Great that we are on the same page. We can simply skip over those pages.
-- 
Michal Hocko
SUSE Labs
