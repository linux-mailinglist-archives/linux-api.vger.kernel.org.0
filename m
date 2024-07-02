Return-Path: <linux-api+bounces-1824-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242D9243EE
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 18:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8751F25F5E
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED311BD504;
	Tue,  2 Jul 2024 16:51:30 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FAF1BC08A;
	Tue,  2 Jul 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939090; cv=none; b=oVAK04xAfrwUD0zun3BZemPiyIpCT+cALWn7N8uZk8hwjcvYhqYQ9JKlis338arSac7vPuIR1QEeUOO+AFWT0fZyYQNMXEHed/J077zokD6SzrENirl1v40pYI6UUcvg87ecbWyOLsx7Na8xg3VnvCRcQ8OaU0XKhqa312sLmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939090; c=relaxed/simple;
	bh=ICrjSB/puKn4FpfGSe2MZmByySg0y3v/6MkyAa0VOnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSvaQ9sTJ0SwCefC42V+JNmXdpzbrAq+AsWmqkAHX40H9pgztuIDULLnXWFOo81jRBDH8DlV0gK1yGqG0OYNQZ41f33W3I1a8aqArSCls7JpH2GloAkx+nJUVI6VIp0J5AmFIldN1dOfIUPRSAu2//yj8LNrmiUefMZzmx6uwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB78C116B1;
	Tue,  2 Jul 2024 16:51:27 +0000 (UTC)
Date: Tue, 2 Jul 2024 12:51:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, "Dmitry V. Levin"
 <ldv@strace.io>, Vincent Donnefort <vdonnefort@google.com>,
 mhiramat@kernel.org, kernel-team@android.com, rdunlap@infradead.org,
 rppt@kernel.org, david@redhat.com, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240702125126.50a6267c@rorschach.local.home>
In-Reply-To: <cb02f5a0-d6a3-4228-9cbb-473fd392ee48@efficios.com>
References: <20240510140435.3550353-1-vdonnefort@google.com>
	<20240510140435.3550353-4-vdonnefort@google.com>
	<20240630105322.GA17573@altlinux.org>
	<20240630084053.0b506916@rorschach.local.home>
	<9a9c8ea4-8e17-4e7e-95fe-7b51441a228c@efficios.com>
	<20240702111807.13d2dd2c@rorschach.local.home>
	<cb02f5a0-d6a3-4228-9cbb-473fd392ee48@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 11:32:53 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> If we use '*' for user events already, perhaps we'd want to consider
> using the same range for the ring buffer ioctls ? Arguably one is
> about instrumentation and the other is about ring buffer interaction
> (data transport), but those are both related to tracing.

Yeah, but I still rather keep them separate.

Beau, care to send a patch adding an entry into that ioctl document for
user events?

-- Steve

