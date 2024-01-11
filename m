Return-Path: <linux-api+bounces-487-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F374F82B383
	for <lists+linux-api@lfdr.de>; Thu, 11 Jan 2024 18:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71869B26BEA
	for <lists+linux-api@lfdr.de>; Thu, 11 Jan 2024 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8A951C4C;
	Thu, 11 Jan 2024 16:59:16 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929AA54BD5
	for <linux-api@vger.kernel.org>; Thu, 11 Jan 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Thu, 11 Jan 2024 11:59:26 -0500
From: Rich Felker <dalias@libc.org>
To: libc-alpha@sourceware.org, musl@lists.openwall.com,
	linux-api@vger.kernel.org
Subject: Re: Robust mutex ABI problem (kernel docs regression)
Message-ID: <20240111165926.GT4163@brightrain.aerifal.cx>
References: <20240111164620.GS4163@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111164620.GS4163@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Jan 11, 2024 at 11:46:21AM -0500, Rich Felker wrote:
> It came to my attention while reviewing some proposals for additional
> error checking in musl libc that the kernel folks introduced a quiet
> regression in the futex ABI for robust mutexes.
> 
> Prior to kernel commit 9c40365a65d62d7c06a95fb331b3442cb02d2fd9, bit
> 29 of the futex lock word was reserved, meaning it could never be part
> of a TID. This allowed both glibc and musl to use special values like
> (glibc):
> 
> /* Magic cookie representing robust mutex with dead owner.  */
> #define PTHREAD_MUTEX_INCONSISTENT      INT_MAX
> /* Magic cookie representing not recoverable robust mutex.  */
> #define PTHREAD_MUTEX_NOTRECOVERABLE    (INT_MAX - 1)
> 
> to represent special states needed for robust mutex consistency
> handling, without the risk that, when masked with FUTEX_TID_MASK
> (0x3fffffff), they could be equal to the TID of a real task, which
> could result in the kernel robustlist-processing mishandling them.

On further investigation, it looks like glibc is not using these
directly in the futex word but keeping them in a separate owner field
protected by the lock. I'll try to follow up with what it actually is
doing, but I don't see a way, without at least having one reserved
value in the low 30 bits (FUTEX_TID_MASK), to represent a lock that
cannot be taken by any task. I'm guessing glibc does some dance of
actually taking the lock then releasing it in this case..?

On musl we keep the entire state in the lock word so that it's all
atomic.

Rich

