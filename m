Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4CB2C287D
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 14:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgKXNmz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 08:42:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387947AbgKXNmX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 08:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606225343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WRSwdJak4MDUgdM4oYuwCfc8hhy9ROBWcZnmVAse6LM=;
        b=cU44JXORPEi3o3XPL7p0dCL/yexe1O7MDvAMpGncce1V4oTQfwWKcDQH2fIrpP2SS1ccG+
        /wOUf5OHsNn9y+l35PPksJrJUEz4WbVGkafvifREafxeowNxFCVtv3cPzUyD4a12b+GWJN
        mf+pak6/S44MxOq+DKGwBLV3OWTRw58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Xdhjv9jxPUycYkJDaQ-JWQ-1; Tue, 24 Nov 2020 08:42:18 -0500
X-MC-Unique: Xdhjv9jxPUycYkJDaQ-JWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43B72805BEC;
        Tue, 24 Nov 2020 13:42:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.234])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D7E360875;
        Tue, 24 Nov 2020 13:42:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 24 Nov 2020 14:42:14 +0100 (CET)
Date:   Tue, 24 Nov 2020 14:42:09 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        christian@brauner.io, timmurray@google.com,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/2] mm/madvise: add process_madvise MADV_DONTNEER support
Message-ID: <20201124134208.GA30125@redhat.com>
References: <20201124053943.1684874-1-surenb@google.com>
 <20201124053943.1684874-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124053943.1684874-3-surenb@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/23, Suren Baghdasaryan wrote:
>
> +	if (madvise_destructive(behavior)) {
> +		/* Allow destructive madvise only on a dying processes */
> +		if (!signal_group_exit(task->signal)) {

signal_group_exit(task) is true if this task execs and kills other threads,
see the comment above this helper.

I think you need !(task->signal->flags & SIGNAL_GROUP_EXIT).

Oleg.

