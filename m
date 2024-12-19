Return-Path: <linux-api+bounces-2943-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB899F7D25
	for <lists+linux-api@lfdr.de>; Thu, 19 Dec 2024 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7463166B6D
	for <lists+linux-api@lfdr.de>; Thu, 19 Dec 2024 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8250225419;
	Thu, 19 Dec 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Vtdn/BOl"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9E01805E;
	Thu, 19 Dec 2024 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618541; cv=none; b=q8fRehS6L/MTrrs6SWunmh1+pwKympqW6ujH58G4iBOoGEvFRpwYRMCMT8v9VS/Zb8lXttkBEQg4GoN6CNm8BWc/8ajnCXSymZ+6M4JK43v77nRo0p3oHtJJKFRkmQA4QOtRkfiVqoBh88y1uwakLyyQs7HTApoC+OWgt0mBm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618541; c=relaxed/simple;
	bh=ik90dd98h/RzD3mNI93eG/7B8uw/H7kZzlpu+ouZ+VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGRzeZdgjiNxXmK1vlE5X0J6oM3E41FvXwNkYRYRyP4bpuQxY+cJvNRk2k8PWiJeMvTZhJONdUAxenKJT4hN51RWgUT64Bc6pBs9Wmr4EEMP12Dmkg5GQTP7B/cVAwqFz6uikgN2prhEydgfPWpn/x4eTn9HdNB76dwmH6RNvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Vtdn/BOl; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KZXVLk08KOTgBa2eUAaNnxKwPWZu+/wmQaAArFb3jy8=; b=Vtdn/BOlZwpEYYc5qhGZsNckQ1
	jJ0ciZYVDJk9kg2WCh8HrtRv2/rt7B+3tHW6n2TL4y0cmzE5JL0MQWlGxUCG7IB+58imnfK2av8C3
	zTwMhfjdu4dEUMukU0VQ7gyTwInOiJ74NzNpvJd+jEM8Y4ytDzQPuZJvhqNmFRApsw8URhgKVtAmn
	zrab71RLQg1x+lrCWFkY7tMvOwnT125SN5CGhNyvI+RSJzzCvc2MrUyP5frH7VxWhqfbd72JscGrO
	3VkF92wwGDCg7JNcqpRr8rFKmGuzYAlK6yLSfBxnURc+db5Mg5pt53PmGwADxv/aY+GMFuL7mJto/
	WGl/wXJA==;
Received: from [179.118.190.62] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tOHVz-005H33-66; Thu, 19 Dec 2024 15:28:35 +0100
Message-ID: <a9b1dde0-7c29-41c3-99be-4749281e25ea@igalia.com>
Date: Thu, 19 Dec 2024 11:28:27 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] futex: Create set_robust_list2
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, sonicadvance1@gmail.com,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-api@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Vinicius Peixoto <vpeixoto@lkcamp.dev>
References: <20241217174958.477692-1-andrealmeid@igalia.com>
 <20241217203140.GH11133@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241217203140.GH11133@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 17/12/2024 17:31, Peter Zijlstra escreveu:
> On Tue, Dec 17, 2024 at 02:49:55PM -0300, André Almeida wrote:
>> This patch adds a new robust_list() syscall. The current syscall
>> can't be expanded to cover the following use case, so a new one is
>> needed. This new syscall allows users to set multiple robust lists per
>> process and to have either 32bit or 64bit pointers in the list.
> 
> Last time a whole list of short comings of the current robust scheme
> were laid bare. I feel we should address all that if we're going to
> create a new scheme.
> 

Are you talking about [1] or is there something else?

[1] https://lore.kernel.org/lkml/87jzdjxjj8.fsf@oldenburg3.str.redhat.com/

