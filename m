Return-Path: <linux-api+bounces-886-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B6984E2CD
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 15:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42681C274EE
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089878B4D;
	Thu,  8 Feb 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQwdbnH3"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB2768E1
	for <linux-api@vger.kernel.org>; Thu,  8 Feb 2024 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401257; cv=none; b=ihk6FIKFF7zJgjrYdAvpxLzDIhQFcr7A9niLtenR2Y9ZgmoLIudprc27cnrEKqBkn148dpU4/CTHXd2zP2JGopWeEbWvWdhfoLpK/mNWpcMg4kG69UVYSoXuEjHI0W5BLxpf8Gf3d0rBLIewgakARpWzziP8OvpAi8G5wtEvtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401257; c=relaxed/simple;
	bh=kdkN1666dxlYpFN1wkFyWk+HZr9DG034hODU02ZZMnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p27Go+CWqLjgZzN1hHNghCjpCrlCNp8RPQsA7NONH21xR4jvdjf3Bt3wB0gnwxs7eWksEfgMMiRn8zWMank8SxzPQdp/mCsmhUa+F3ersPoliFXUQFpcqB1semK5wNhzFl8doH8EY8lSDEPj1gWwK8a+2KQ6P2bCP5jcD9rSORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQwdbnH3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707401254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kdkN1666dxlYpFN1wkFyWk+HZr9DG034hODU02ZZMnc=;
	b=EQwdbnH3Og643PXzBLJeSX28zWxiMq+smaO6x67ltj5Jz529Ky+oYJG8D1jNsN6xazyzFH
	ryl+WCEq12FW6bUpVqiquDYljbkTfh9QOWt39nWer545Adu8n2KmhWhtMEMvX1IQ16EZAf
	87rDB521zheYxP4QCrKEub9H3VVhsbI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-RINaUWZCONCKEsYUTXb-Yg-1; Thu,
 08 Feb 2024 09:07:29 -0500
X-MC-Unique: RINaUWZCONCKEsYUTXb-Yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 829053C13AAC;
	Thu,  8 Feb 2024 14:07:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.158])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3A7662026D06;
	Thu,  8 Feb 2024 14:07:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Feb 2024 15:06:12 +0100 (CET)
Date: Thu, 8 Feb 2024 15:06:10 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208140610.GE19801@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-fragt-prospekt-7866333b15f0@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/08, Christian Brauner wrote:
>
> I would also suggest we update the obsolete comment on top of
> pidfd_send_signal() along the lines of:

Yes, but...

> + * If the @pidfd refers to a thread-group leader the signal is thread-group
> + * directed. If @pidfd referes to a thread then the signal is thread directed.

No, this depends on PIDFD_THREAD only.

If it is set then the signal is always "thread directed" even if @pidfd refers
to a thread-group leader.

Otherwise the target task must be a group leader and the signal will be
"thread-group directed".

Right?

Oleg.


