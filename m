Return-Path: <linux-api+bounces-2439-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE909A1318
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2024 22:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B252A28170A
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2024 20:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18055216A31;
	Wed, 16 Oct 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bH9msgWp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C7215F52
	for <linux-api@vger.kernel.org>; Wed, 16 Oct 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108833; cv=none; b=dzOYeKpwr97vMam4euggc+jg0NKp0W3B3bx0sYeQaEwT8ExrGnH1H0tivRwvs4MyjWls3bmPMOsmz4xLyGemOJosj5/u5FZP+S9KfQvE2+mQmJmeoqpSFPfLg+n7TUH0UXXb7LTnQqaUrxVi+URPdlnSZ3wjVgB1jtuP6xWrKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108833; c=relaxed/simple;
	bh=GXWa88oli4PWmA5+fzUJhszGi/k7b0FRJFJ5Zof4XW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCC1/wyeLiostxYcV+x1xRTwSrkeDkFpkRVFu6tq8C6AElz1VEzXMWkErmXD6x8HvCBfTxDKufjPD5x8coArv6XOUu/GG/leFkoCxCO91iv0Dm7ULCcsIpR9rEFU6GQ4vhAEtCgMnRKWx5yZly5bEK3/yprzyf9V+e5gPXmwKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bH9msgWp; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83aaf8189bcso1091939f.2
        for <linux-api@vger.kernel.org>; Wed, 16 Oct 2024 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729108829; x=1729713629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PVXpXafwswvIYBcxSLxNIvr3U2zHo65AX9f3Pm1fo0=;
        b=bH9msgWpZgjmM5tcDOFe5xlK6iQ5HoiF8Elbmk3nLjD9EoLb1Sv++CRN/jByRQEgx8
         18gAemz9xd6Bh/9Nbr/8gH2vRskgxmrwInye065u39Ff3PRtnK5ItCwBRR1AnLlxFqoA
         EEeGLL8/cZy2otxIcm0E2EU91WADcx/iTtkzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729108829; x=1729713629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PVXpXafwswvIYBcxSLxNIvr3U2zHo65AX9f3Pm1fo0=;
        b=o3gHQVCIqRIZPXSKpbW3K/Hv01fpEK5n3IasnUy056Lhy5LF3PgNE4+YSOgUMGJqW6
         +MrFasfvf+L3ewGBPCt21QR3VBvMn3/Z+Ut3Y1Aup4vGrv4dSW8bfNM6LCU9nmFQg+pE
         rcePbxyicg/ZdthyO/JDWsijnu3m8nBPwKdlJL9deRty+GLqEnQIFPWzp1p8dRmJP7Uf
         5XHvcUqThhl3GHz5j2RB6JO6jLriQqpjSt36W8M89+UruPPq9j+TfPDJ5+Jt/m3w96Ki
         +vpL03LRs2kxX5wRw4uEUMrtJcV0GjjsksUSWkmPg9A1JcJzqVWHI/PlP3J/2to6GQsH
         a1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoZO7O0h+S4jRd8hZ+XIUKVcOspKd3psyWM39046WvFEZMvJmkgTYj/21af+wAHLl1JNeYLGz7W1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2lmbnB6FuYhO9WQnv9jaVSaTzIylRhgYtjwwzqXySfXcvt2e
	7djSatZrI60FPJIgqNssa79pNiQkZPJcmCSJi1RMjoMpmiYaPku5WkXyBYm7v54=
X-Google-Smtp-Source: AGHT+IFhemGMrTXm0sMyQyLUJ9gqBzqux5ju24bsXrdrLEcJKKlddo3PTMuUfwbHsZl+/lq10WstqQ==
X-Received: by 2002:a05:6602:6403:b0:837:7f69:eac2 with SMTP id ca18e2360f4ac-8379241ac0emr1848647239f.1.1729108829163;
        Wed, 16 Oct 2024 13:00:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc44a2asm981213173.154.2024.10.16.13.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 13:00:28 -0700 (PDT)
Message-ID: <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
Date: Wed, 16 Oct 2024 14:00:27 -0600
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/24 04:20, Lorenzo Stoakes wrote:
> Add tests to assert that PIDFD_SELF_* correctly refers to the current
> thread and process.
> 
> This is only practically meaningful to pidfd_send_signal() and
> pidfd_getfd(), but also explicitly test that we disallow this feature for
> setns() where it would make no sense.
> 
> We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
> theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.
> 
> We defer testing of mm-specific functionality which uses pidfd, namely
> process_madvise() and process_mrelease() to mm testing (though note the
> latter can not be sensibly tested as it would require the testing process
> to be dying).
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   tools/testing/selftests/pidfd/pidfd.h         |   8 +
>   .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
>   .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
>   tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
>   4 files changed, 224 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index 88d6830ee004..1640b711889b 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -50,6 +50,14 @@
>   #define PIDFD_NONBLOCK O_NONBLOCK
>   #endif
>   
> +/* System header file may not have this available. */
> +#ifndef PIDFD_SELF_THREAD
> +#define PIDFD_SELF_THREAD -100
> +#endif
> +#ifndef PIDFD_SELF_THREAD_GROUP
> +#define PIDFD_SELF_THREAD_GROUP -200
> +#endif
> +

As mentioned in my response to v1 patch:

kselftest has dependency on "make headers" and tests include
headers from linux/ directory

These local make it difficult to maintain these tests in the
longer term. Somebody has to go clean these up later.

The import will be fine and you can control that with -I flag in
the makefile. Remove these and try to get including linux/pidfd.h
working.

Please revise this patch to include the header file and remove
these local defines.

thanks,
-- Shuah

