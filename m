Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81C38CDE9
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 21:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhEUTKd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhEUTKc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 15:10:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2AFC061574;
        Fri, 21 May 2021 12:09:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x188so15591454pfd.7;
        Fri, 21 May 2021 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s9Cp5133Mh+/zqJfqgPhMnUlYEemgkFwhti63wW8kUI=;
        b=fax43L1MPYF/lupgd8kkNEx9vH7DU3byne426xeI/wDqFC3pAht4iLEVX2hxPB/Hy6
         lnX1ztghXBFoS4mXs7mm4yAxG6vRf/Ix9UsGb02wTErrT9igsZlqmNn3aeUuQslcnijG
         QO73zK6L9+9HCGZRpV5xJri82E4yZD4FiRm09B24nUAeamxTB/IVLjqAH9CinY+x/vcA
         LJCntK01UZI3qD+Xl9Zj2ikfOF4C1cdJIGhn/WVNWV+nyZMFgjxzvTNxrsbtpr7mdfCV
         7nmx8smDbD3/C95oE6dvN3TPcHb+tVT58Y23ZstOyzHVsgFlcN00Ied5bnOrLEftTZDT
         k3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s9Cp5133Mh+/zqJfqgPhMnUlYEemgkFwhti63wW8kUI=;
        b=cWnbrElusloBJHHEmBoNqmj2Ma5CvNQ9YtK/rWJtKxRPyekZVm7HcvfLnywP0omAJt
         cVKJY0hFvNE8Vkmu+IQs20kozaBLD2qMbtDqkB0/grZcm1uS3GKiktr9Ffi545UjA9NZ
         tTLdgdCeNzacBhQWrZsWEcGSi/BQcjAr4IQViKWsIfVSYscU+gQXaKiVLVmqSpgCYqgZ
         BLWGIkjfNKMvtRI8m3HnhEEmtDsNbUNDdG5+2x9sk3+/7X9vIXlKbw/bCYrxUlgcdW2y
         3MOfgUOANt99wD81yul+sf2OnGJmhXFA2pRlrbDs0GED+DafnZ/ilW65ydTm9YaUKt1O
         rgIQ==
X-Gm-Message-State: AOAM531tZZ0KJQX7tvhtUK62jyBke1uztgmiGJodeZMBopBN5feEQtFr
        YjLihGp7egdbdTzBWsMlblI=
X-Google-Smtp-Source: ABdhPJzMe31162py2dDnpEKn8gX+Saka8i654M1Dicx1XmDSbBCA5qpkLnHZ+G8eWEd6cH4sshlYXA==
X-Received: by 2002:a63:1d2:: with SMTP id 201mr205962pgb.3.1621624148325;
        Fri, 21 May 2021 12:09:08 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id 6sm4911081pfx.117.2021.05.21.12.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:09:07 -0700 (PDT)
Date:   Fri, 21 May 2021 12:06:07 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Subject: Re: [RFC PATCH v0.1 4/9] sched/umcg: implement core UMCG API
Message-ID: <YKgEn/TBsTyhk0m1@gmail.com>
References: <20210520183614.1227046-1-posk@google.com>
 <20210520183614.1227046-5-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210520183614.1227046-5-posk@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 11:36:09AM -0700, Peter Oskolkov wrote:
> @@ -67,7 +137,75 @@ SYSCALL_DEFINE4(umcg_register_task, u32, api_version, u32, flags, u32, group_id,
>   */
>  SYSCALL_DEFINE1(umcg_unregister_task, u32, flags)
>  {
> -	return -ENOSYS;
> +	struct umcg_task_data *utd;
> +	int ret = -EINVAL;
> +
> +	rcu_read_lock();
> +	utd = rcu_dereference(current->umcg_task_data);
> +
> +	if (!utd || flags)
> +		goto out;
> +
> +	task_lock(current);
> +	rcu_assign_pointer(current->umcg_task_data, NULL);
> +	task_unlock(current);
> +
> +	ret = 0;
> +
> +out:
> +	rcu_read_unlock();
> +	if (!ret && utd) {
> +		synchronize_rcu();

synchronize_rcu is expensive. Do we really need to call it here? Can we
use kfree_rcu?

Where is task->umcg_task_data freed when a task is destroyed?

> +		kfree(utd);
> +	}
> +	return ret;
> +}
> +
