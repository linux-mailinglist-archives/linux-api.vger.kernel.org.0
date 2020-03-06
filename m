Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A817BADF
	for <lists+linux-api@lfdr.de>; Fri,  6 Mar 2020 11:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCFK5Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Mar 2020 05:57:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:59182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgCFK5Y (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Mar 2020 05:57:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2699AC50;
        Fri,  6 Mar 2020 10:57:22 +0000 (UTC)
Subject: Re: [PATCH v7 4/7] pid: move pidfd_get_pid function to pid.c
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
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
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian@brauner.io>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-5-minchan@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f0f5f948-4025-0f27-951f-dc1dab1c5a0d@suse.cz>
Date:   Fri, 6 Mar 2020 11:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302193630.68771-5-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/2/20 8:36 PM, Minchan Kim wrote:
> process_madvise syscall needs pidfd_get_pid function to translate
> pidfd to pid so this patch move the function to kernel/pid.c.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Christian Brauner <christian@brauner.io>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
