Return-Path: <linux-api+bounces-869-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C984C8B4
	for <lists+linux-api@lfdr.de>; Wed,  7 Feb 2024 11:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105831C24B03
	for <lists+linux-api@lfdr.de>; Wed,  7 Feb 2024 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F2134C4;
	Wed,  7 Feb 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFhgze8c"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6DA1AB7E6
	for <linux-api@vger.kernel.org>; Wed,  7 Feb 2024 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302006; cv=none; b=OVVxYwm1f2LfV1x+XfyGM20cYXvMyK60tqRCHj+Rogqgm1uEbLqvM2y2He765ZmHoAKe0acwu36wEeLE2LnmwSuoKx8LVkMYWtbK+AiR44iw1HjXZ3+ppF/c7JXCyhxObbe6RGKAfEwbS+sT/xmUdNLNUkxzsCl5FzQkeFxnJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302006; c=relaxed/simple;
	bh=vLXGv1EUKmS8dtKvb8mpu+/jx8nLcaWSFNexa86Ni+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq7uryDi3IZnIZ9qC3eruyIFy0NuiWCoUN4p/moffTy/WAwQL8NEHxDYcOeg1gRxrJARL7GEPUmqWMbACWmKur8WFEZiSXVD0b9K22361K2C3fxB8tbM39Qwm0OFYtR+UnnYs8hF96uSqrqBJ2YI14reIyifvvYMLNAHAESzHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFhgze8c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707302003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLXGv1EUKmS8dtKvb8mpu+/jx8nLcaWSFNexa86Ni+A=;
	b=RFhgze8cIE3KouGxWfiWbbyAjcyMCoAtxa4ZmgvSzL6orEm3CyToSLcv3JRCjueMcCPcbR
	qE/PiX5Br+yJnY7I71qJmgDJvG51RcbnkH0Xk807eb04dIjLChxecsn5wUcMaN5+FeZ2WS
	E9Z8ZyCir1WCt6UEJVeaAPDNvctJsGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-2idMZ__JM6qpwL81IFxJCg-1; Wed, 07 Feb 2024 05:33:20 -0500
X-MC-Unique: 2idMZ__JM6qpwL81IFxJCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F358785A58A;
	Wed,  7 Feb 2024 10:33:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.212])
	by smtp.corp.redhat.com (Postfix) with SMTP id 559DB2026D06;
	Wed,  7 Feb 2024 10:33:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Feb 2024 11:32:03 +0100 (CET)
Date: Wed, 7 Feb 2024 11:32:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v2] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240207103201.GB6627@redhat.com>
References: <20240206192357.81942-1-tycho@tycho.pizza>
 <20240207-vibrieren-waldarbeiten-30eeade05203@brauner>
 <20240207-daran-fliesen-6039a2e36f39@brauner>
 <20240207-blumen-neulich-f1507e0c5cc0@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-blumen-neulich-f1507e0c5cc0@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/07, Christian Brauner wrote:
>
> So this is what I have applied currently where I moved the check into
> __pidfd_fget() where it makes more sense imho. But please double check
> that I didn't mess anything up:

LGTM.

You have already applied this patch, no need to add my ack, but FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


