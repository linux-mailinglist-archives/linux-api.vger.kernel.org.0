Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A0069211B
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjBJOqw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 09:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjBJOqv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 09:46:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E647406B
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 06:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676040319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zels36cVrx0AVFMqsJG4hmmNwOppGbD1Lpolz/Rld+4=;
        b=Ua+k7nHmmjqxms0qy1KoAoozF180KBh9PZkpr4Om/kacdrHcBivpJ1+3ZEPpjSY2omVos+
        3zAQFHRMoqc4j31yHktOsRdXAKnN1IO4H4HiRXBvz8TxqNX9hS/q44bHoXKwDasEkut8OB
        nL3ev6/uXRTs2twgwrfZdhtS6xzoZFE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-510-m_tWkWqNOVCdJTJB98QV4g-1; Fri, 10 Feb 2023 09:45:18 -0500
X-MC-Unique: m_tWkWqNOVCdJTJB98QV4g-1
Received: by mail-qk1-f199.google.com with SMTP id q13-20020a37f70d000000b007283b33bfb3so3374164qkj.4
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 06:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zels36cVrx0AVFMqsJG4hmmNwOppGbD1Lpolz/Rld+4=;
        b=OrQbOLvgIuNUnzcgQVhuzpu7LmM4jjgKtGwcxGN6oMPrrdm97Xexni6/Bx1S3Md8Sf
         cWPbatxjlg9dkKoUAro+xsuX/jeakGIbY5DGkwE1g2PiG5EDWCjGH4TZobv2R4B2tkho
         n8guh9dtV3R1ozR/7aDC8JbP/OqKQNT1YeoUFbO5msUUES/DpbbxsEkhtx1Hz39ou5Vr
         EeMnxCuBPvnV8nvaFswgS3+qOVcTnZbRi3VmK+sKlZYJ3QvqjJz/l4E3sugmDANqQ40l
         5O5ol5aUuCGQCfLIPBXmEpetTFpPcNI14ys1EuOn3vqAIhYpsa1Fi16kFSG83F512QDu
         pZEQ==
X-Gm-Message-State: AO0yUKXZ0KKpZl1m76WLLYnZG5TkcD7kd14GXPOuUOh2/tX/c1MgW1ui
        elAbOC1AoZ7QDGHQd1YyHOXjI06eX9bZ/6Mp4kSRWWIcXlfgv0rKw/rV93ncBosqXckzVl/oi13
        QjNs6foh4XgfTIQaQJPkE
X-Received: by 2002:ac8:5c0a:0:b0:3bb:7649:bd89 with SMTP id i10-20020ac85c0a000000b003bb7649bd89mr18509342qti.61.1676040317853;
        Fri, 10 Feb 2023 06:45:17 -0800 (PST)
X-Google-Smtp-Source: AK7set8j6r+I/zR1st20DSGpi8GFEhTd8duAK2l2ncty4viLpSrZrC5sxsAnnWknNcPFzWGzPi/hcg==
X-Received: by 2002:ac8:5c0a:0:b0:3bb:7649:bd89 with SMTP id i10-20020ac85c0a000000b003bb7649bd89mr18509304qti.61.1676040317541;
        Fri, 10 Feb 2023 06:45:17 -0800 (PST)
Received: from [192.168.0.2] (ip-109-43-178-85.web.vodafone.de. [109.43.178.85])
        by smtp.gmail.com with ESMTPSA id n12-20020ac81e0c000000b003b82cb8748dsm3382607qtl.96.2023.02.10.06.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:45:17 -0800 (PST)
Message-ID: <3b9c5496-6631-37ad-9c3d-f0f06fa1308e@redhat.com>
Date:   Fri, 10 Feb 2023 15:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 06/14] Move ep_take_care_of_epollwakeup() to
 fs/eventpoll.c
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@plumgrid.com, aishchuk@linux.vnet.ibm.com, aarcange@redhat.com,
        akpm@linux-foundation.org, luto@kernel.org, acme@kernel.org,
        bhe@redhat.com, 3chas3@gmail.com, chris@zankel.net, dave@sr71.net,
        dyoung@redhat.com, drysdale@google.com, ebiederm@xmission.com,
        geoff@infradead.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        mingo@kernel.org, iulia.manda21@gmail.com, plagnioj@jcrosoft.com,
        jikos@kernel.org, josh@joshtriplett.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, jcmvbkbc@gmail.com,
        paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl,
        tglx@linutronix.de, tomi.valkeinen@ti.com, vgoyal@redhat.com,
        x86@kernel.org, arnd@arndb.de, dhowells@redhat.com,
        peterz@infradead.org, Jens Axboe <axboe@kernel.dk>
References: <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
 <1447119071-19392-1-git-send-email-palmer@dabbelt.com>
 <1447119071-19392-7-git-send-email-palmer@dabbelt.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <1447119071-19392-7-git-send-email-palmer@dabbelt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/11/2015 02.31, Palmer Dabbelt wrote:
> This doesn't make any sense to expose to userspace, so it's been moved
> to the one user.  This was introduced by commit 95f19f658ce1 ("epoll:
> drop EPOLLWAKEUP if PM_SLEEP is disabled").
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
> Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
> ---
>   fs/eventpoll.c                 | 13 +++++++++++++
>   include/uapi/linux/eventpoll.h | 12 ------------
>   2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 1e009ca..aadee3d 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1812,6 +1812,19 @@ SYSCALL_DEFINE1(epoll_create, int, size)
>   	return sys_epoll_create1(0);
>   }
>   
> +#ifdef CONFIG_PM_SLEEP
> +static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
> +{
> +	if ((epev->events & EPOLLWAKEUP) && !capable(CAP_BLOCK_SUSPEND))
> +		epev->events &= ~EPOLLWAKEUP;
> +}
> +#else
> +static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
> +{
> +	epev->events &= ~EPOLLWAKEUP;
> +}
> +#endif
> +
>   /*
>    * The following function implements the controller interface for
>    * the eventpoll file that enables the insertion/removal/change of
> diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> index bc81fb2..7850373 100644
> --- a/include/uapi/linux/eventpoll.h
> +++ b/include/uapi/linux/eventpoll.h
> @@ -61,16 +61,4 @@ struct epoll_event {
>   	__u64 data;
>   } EPOLL_PACKED;
>   
> -#ifdef CONFIG_PM_SLEEP
> -static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
> -{
> -	if ((epev->events & EPOLLWAKEUP) && !capable(CAP_BLOCK_SUSPEND))
> -		epev->events &= ~EPOLLWAKEUP;
> -}
> -#else
> -static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
> -{
> -	epev->events &= ~EPOLLWAKEUP;
> -}
> -#endif
>   #endif /* _UAPI_LINUX_EVENTPOLL_H */

  Hi!

Looks like this patch has never been merged? ... I just came across this 
"#ifdef CONFIG_..." in the uapi directory, and it also seems wrong to me to 
check CONFIG_* switches here, so could somebody maybe pick this patch up now 
and merge it?

  Thanks,
   Thomas

