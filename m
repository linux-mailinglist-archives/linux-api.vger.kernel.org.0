Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109FA33971B
	for <lists+linux-api@lfdr.de>; Fri, 12 Mar 2021 20:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhCLTHE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Mar 2021 14:07:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234159AbhCLTGs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Mar 2021 14:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615576007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pWyz36koqRQcLJypWgN3Jo6QKc24/Z5WKte5SZjr3Xs=;
        b=KADNAK9QXxQMVHsCVspxDWKrEdtR9na6Tz5vx0nyRUiLeJSILuwdqaNf0Mm8FrKprIx8ix
        1xSH6tZMhB88XdMrJAzGsfxUJDFzGsghD7X1TL58TkTO445/86LzxhpSNb27L8zhdDmCMP
        zn+6PrV5RJm6rWTKqRpQIVVGUYbPwHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-OmSAVjrKPZ61QqTHc0WCxA-1; Fri, 12 Mar 2021 14:06:44 -0500
X-MC-Unique: OmSAVjrKPZ61QqTHc0WCxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DD55101872B;
        Fri, 12 Mar 2021 19:06:42 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 497E660C9B;
        Fri, 12 Mar 2021 19:06:42 +0000 (UTC)
Date:   Fri, 12 Mar 2021 14:06:41 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        pavel.tide@veeam.com
Subject: Re: [PATCH v7 1/3] block: add blk_mq_is_queue_frozen()
Message-ID: <20210312190641.GA2550@redhat.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-2-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615563895-28565-2-git-send-email-sergei.shtepa@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 12 2021 at 10:44am -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> blk_mq_is_queue_frozen() allow to assert that the queue is frozen.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  block/blk-mq.c         | 13 +++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d4d7c1caa439..2f188a865024 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -161,6 +161,19 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
>  
> +bool blk_mq_is_queue_frozen(struct request_queue *q)
> +{
> +	bool frozen;
> +
> +	mutex_lock(&q->mq_freeze_lock);
> +	frozen = percpu_ref_is_dying(&q->q_usage_counter) &&
> +		 percpu_ref_is_zero(&q->q_usage_counter);
> +	mutex_unlock(&q->mq_freeze_lock);
> +
> +	return frozen;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_is_queue_frozen);
> +

This is returning a frozen state that is immediately stale.  I don't
think any code calling this is providing the guarantees you think it
does due to the racey nature of this state once the mutex is dropped.

>  /*
>   * Guarantee no request is in use, so we can change any data structure of
>   * the queue afterward.
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 2c473c9b8990..6f01971abf7b 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -533,6 +533,7 @@ void blk_freeze_queue_start(struct request_queue *q);
>  void blk_mq_freeze_queue_wait(struct request_queue *q);
>  int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
>  				     unsigned long timeout);
> +bool blk_mq_is_queue_frozen(struct request_queue *q);
>  
>  int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
> -- 
> 2.20.1
> 

