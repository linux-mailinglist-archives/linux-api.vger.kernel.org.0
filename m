Return-Path: <linux-api+bounces-2789-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27389D9106
	for <lists+linux-api@lfdr.de>; Tue, 26 Nov 2024 05:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D792169CB7
	for <lists+linux-api@lfdr.de>; Tue, 26 Nov 2024 04:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372923AC2B;
	Tue, 26 Nov 2024 04:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cqMvCkiF"
X-Original-To: linux-api@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1E10E6;
	Tue, 26 Nov 2024 04:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732595253; cv=none; b=gluL4aecHF8Bvfcf03bpVg7PETsME/W7JRn/7a75eMWq8GPFUaV0Ozm/neBMR1koO3kT4/MhtUKDysBhCPy4VwK0H/fypXEBrWoKl0J+8NZpPJDoOihJvnixzHHydXJEo/EcmygPmSkrQNeojQPUnEJabg026LdsT2rbAiHsaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732595253; c=relaxed/simple;
	bh=aX/b+UTO81Nt07pDPl00uRiI3vW9Yf4VER1ahKxy0Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R6gw4PwnP7Yxq7equba8ieX6TmhdXh9ur2HhagmqCOSl4e6WEMA3RMTH96Yx6Tz/2VTVcQ8K22L613/xWwulhOivZAhGqQwt8t/qHYLmDgaPrHUd414wu79CtZru6PCaMtaPVMbhAWhinvlpbEGffBQWdHjzwkTpEH7Ft5AcuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cqMvCkiF; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732595247; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9fdQvl9sFAN5+qJlrKwyEI1XXekh060PCb6cxd/vT7Q=;
	b=cqMvCkiF2rFbmVDTrXgr3e+GUHu4ZzO4v0Vpg6iLQoB7qWoS0jSRJp526USiDFhGpdobnnIESWk+T97FS+mQF8Ml6oHbpYfwBgCIhaKm1U++g2C8c7VIoX8HuscOTJtNat/In7Bp+kR1NMseiffSb7I9pdxN5VzuE95Yq0/hx0I=
Received: from 30.221.146.228(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WKGnheK_1732595245 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 12:27:26 +0800
Message-ID: <f81a78ac-b32a-44bf-9375-8ac380bbce74@linux.alibaba.com>
Date: Tue, 26 Nov 2024 12:27:25 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
 linux-api@vger.kernel.org
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <20241111234006.5942-13-ouster@cs.stanford.edu>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20241111234006.5942-13-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/24 7:40 AM, John Ousterhout wrote:
> Before this commit the Homa code is "inert": it won't be compiled
> in kernel builds. This commit adds Homa's Makefile and Kconfig, and
> also links Homa into net/Makefile and net/Kconfig, so that Homa
> will be built during kernel builds if enabled (it is disabled by
> default).
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>   MAINTAINERS       |  7 +++++++
>   net/Kconfig       |  1 +
>   net/Makefile      |  1 +
>   net/homa/Kconfig  | 19 +++++++++++++++++++
>   net/homa/Makefile | 14 ++++++++++++++
>   5 files changed, 42 insertions(+)
>   create mode 100644 net/homa/Kconfig
>   create mode 100644 net/homa/Makefile
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1389704c7d8d..935d1e995018 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10391,6 +10391,13 @@ F:	lib/test_hmm*
>   F:	mm/hmm*
>   F:	tools/testing/selftests/mm/*hmm*
>   
> +HOMA TRANSPORT PROTOCOL
> +M:	John Ousterhout <ouster@cs.stanford.edu>
> +S:	Maintained
> +W:	https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
> +F:	include/uapi/linux/homa.h
> +F:	net/homa/
> +
>   HONEYWELL HSC030PA PRESSURE SENSOR SERIES IIO DRIVER
>   M:	Petre Rodan <petre.rodan@subdimension.ro>
>   L:	linux-iio@vger.kernel.org
> diff --git a/net/Kconfig b/net/Kconfig
> index a629f92dc86b..ca8551c1a226 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -244,6 +244,7 @@ endif
>   
>   source "net/dccp/Kconfig"
>   source "net/sctp/Kconfig"
> +source "net/homa/Kconfig"
>   source "net/rds/Kconfig"
>   source "net/tipc/Kconfig"
>   source "net/atm/Kconfig"
> diff --git a/net/Makefile b/net/Makefile
> index 65bb8c72a35e..18fa3c323187 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -44,6 +44,7 @@ obj-y				+= 8021q/
>   endif
>   obj-$(CONFIG_IP_DCCP)		+= dccp/
>   obj-$(CONFIG_IP_SCTP)		+= sctp/
> +obj-$(CONFIG_HOMA)              += homa/

A small formatting issue, perhaps you're using spaces?


>   obj-$(CONFIG_RDS)		+= rds/
>   obj-$(CONFIG_WIRELESS)		+= wireless/
>   obj-$(CONFIG_MAC80211)		+= mac80211/
> diff --git a/net/homa/Kconfig b/net/homa/Kconfig
> new file mode 100644
> index 000000000000..8ba81b00d35f
> --- /dev/null
> +++ b/net/homa/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +#
> +# Homa transport protocol
> +#
> +
> +menuconfig HOMA
> +	tristate "The Homa transport protocol"
> +	depends on INET
> +	depends on IPV6

Can HOMA run in an environment without IPv6（IPv4 only)? If so, depends is not suitable here. Perhaps 
what you need is to implement different branches in the code using

#if IS_ENABLED(CONFIG_IPV6)

> +
> +	help
> +	Homa is a network transport protocol for communication within
> +	a datacenter. It provides significantly lower latency than TCP,
> +	particularly for workloads containing a mixture of large and small
> +	messages operating at high network utilization. For more information
> +	see the homa(7) man page or checkout the Homa Wiki at
> +	https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview.
> +
> +	If unsure, say N.
> diff --git a/net/homa/Makefile b/net/homa/Makefile
> new file mode 100644
> index 000000000000..3eb192a6ffa6
> --- /dev/null
> +++ b/net/homa/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +#
> +# Makefile for the Linux implementation of the Homa transport protocol.
> +
> +obj-$(CONFIG_HOMA) := homa.o
> +homa-y:=        homa_incoming.o \
> +		homa_outgoing.o \
> +		homa_peer.o \
> +		homa_pool.o \
> +		homa_plumbing.o \
> +		homa_rpc.o \
> +		homa_sock.o \
> +		homa_timer.o \
> +		homa_utils.o

