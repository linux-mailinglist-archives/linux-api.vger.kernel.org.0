Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6A203CF
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEPKoQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 06:44:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:55612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbfEPKoQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 16 May 2019 06:44:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98DF2ACC1;
        Thu, 16 May 2019 10:44:14 +0000 (UTC)
Date:   Thu, 16 May 2019 12:44:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] mm/ksm, proc: introduce remote madvise
Message-ID: <20190516104412.GN16651@dhcp22.suse.cz>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 16-05-19 11:42:29, Oleksandr Natalenko wrote:
[...]
> * to mark all the eligible VMAs as mergeable, use:
> 
>    # echo merge > /proc/<pid>/madvise
> 
> * to unmerge all the VMAs, use:
> 
>    # echo unmerge > /proc/<pid>/madvise

Please do not open a new thread until a previous one reaches some
conclusion. I have outlined some ways to go forward in
http://lkml.kernel.org/r/20190515145151.GG16651@dhcp22.suse.cz.
I haven't heard any feedback on that, yet you open a 3rd way in a
different thread. This will not help to move on with the discussion.

Please follow up on that thread.
-- 
Michal Hocko
SUSE Labs
