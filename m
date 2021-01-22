Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001242FFE3F
	for <lists+linux-api@lfdr.de>; Fri, 22 Jan 2021 09:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbhAVIdd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Jan 2021 03:33:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:58868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbhAVIdU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 22 Jan 2021 03:33:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611304354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYCHwHrCC9WJUfKullQqBNBK7/2N0huPDEnTqw+26SU=;
        b=jdc3dpRdRCKkGZ1rwdh5caZjZiHFZkXSGjCSqMLAhA8cWGIKmmT82nH5FLJSC/NMwVRJTj
        me/mgeOqybIqRi2EYZxfY1Q2I7JoKdKisjS0Yc39EcS1bNUrcgeJ9dD9EQU+D9ryQTRULf
        t6EezV8N2c5tKomCRZM3QSO7rybxWB0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DCBBACC6;
        Fri, 22 Jan 2021 08:32:34 +0000 (UTC)
Date:   Fri, 22 Jan 2021 09:32:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, elver@google.com, andreyknvl@google.com,
        dvyukov@google.com, mingo@redhat.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux-mm@kvack.org,
        linux-api@vger.kernel.org, vbabka@suse.cz,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 0/3] Add error_report_end tracepoint to KFENCE and
 KASAN
Message-ID: <YAqNoTWfp7HQ9c5m@alley>
References: <20210121131915.1331302-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121131915.1331302-1-glider@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 2021-01-21 14:19:12, Alexander Potapenko wrote:
> This patchset adds a tracepoint, error_repor_end, that is to be used by
> KFENCE, KASAN, and potentially other bug detection tools, when they
> print an error report.
> One of the possible use cases is userspace collection of kernel error
> reports: interested parties can subscribe to the tracing event via
> tracefs, and get notified when an error report occurs.
> 
> v3:
>  - dropped the sysfs interface for log collection
>  - dropped error_report_start tracepoint

Just for record. This approach looks reasonable to me.
Thanks for removing the sysfs interface. It would have been
a potential can of worms.

I do not feel eligible to add any tag. I am neither familiar
with the tracepoint nor the KFENCE or KASAN code.

Best Regards,
Petr
