Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A487322E8A
	for <lists+linux-api@lfdr.de>; Tue, 23 Feb 2021 17:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhBWQQ0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Feb 2021 11:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232733AbhBWQQV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Feb 2021 11:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614096893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeWt/IdGTJbN0yFn1dINL5p2N/1MlBP7qkRn7zeQuR0=;
        b=NkWubLjb0SbzRS2MEiWdF5YJ3oE/N+tRQK4bMN1AT2t3gDLKcR+ub6nn0+Dcz8T+zGBpQ5
        1sg3MbrxvuCQ7MfMb9wjD0eVsjS+5mUmOQPclWoZ8UOkkF7R/FPjgg7Xr5JvAnC9XSgsj3
        PQ6hEaqUElIclJr9n6AA4yjsuFFx3P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-YAmqfG1jNpG7T0OnNp1QDw-1; Tue, 23 Feb 2021 11:14:49 -0500
X-MC-Unique: YAmqfG1jNpG7T0OnNp1QDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3326791271;
        Tue, 23 Feb 2021 16:14:32 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-113-131.ams2.redhat.com [10.36.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16EBD722CE;
        Tue, 23 Feb 2021 16:14:24 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Piotr Figiel <figiel@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@kernel.org, boqun.feng@gmail.com, oleg@redhat.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com, emmir@google.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
References: <20210222100443.4155938-1-figiel@google.com>
Date:   Tue, 23 Feb 2021 17:15:08 +0100
In-Reply-To: <20210222100443.4155938-1-figiel@google.com> (Piotr Figiel's
        message of "Mon, 22 Feb 2021 11:04:43 +0100")
Message-ID: <878s7ewyk3.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Piotr Figiel:

> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index 83ee45fa634b..d54cf6b6ce7c 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -102,6 +102,14 @@ struct ptrace_syscall_info {
>  	};
>  };
>  
> +#define PTRACE_GET_RSEQ_CONFIGURATION	0x420f
> +
> +struct ptrace_rseq_configuration {
> +	__u64 rseq_abi_pointer;
> +	__u32 signature;
> +	__u32 pad;
> +};

The flags and the structure size appear to be missing here.

Thanks,
Florian

