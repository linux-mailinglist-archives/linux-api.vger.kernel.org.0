Return-Path: <linux-api+bounces-32-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810287E8B0A
	for <lists+linux-api@lfdr.de>; Sat, 11 Nov 2023 14:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB61F20F05
	for <lists+linux-api@lfdr.de>; Sat, 11 Nov 2023 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044E1172B;
	Sat, 11 Nov 2023 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-api@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786114A84
	for <linux-api@vger.kernel.org>; Sat, 11 Nov 2023 13:24:38 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E07CE30C2;
	Sat, 11 Nov 2023 05:24:36 -0800 (PST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 3ABDOVvp003734;
	Sat, 11 Nov 2023 14:24:31 +0100
Date: Sat, 11 Nov 2023 14:24:31 +0100
From: Willy Tarreau <w@1wt.eu>
To: York Jasper Niebuhr <yjnworkstation@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] exitz syscall
Message-ID: <20231111132431.GA3717@1wt.eu>
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111125126.11665-1-yjnworkstation@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hello,

On Sat, Nov 11, 2023 at 01:51:26PM +0100, York Jasper Niebuhr wrote:
> Adds a system call to flag a process' resources to be cleared on
> exit (or, in the case of memory, on free). Currently, only zeroing
> memory is implemented.
(...)

IMHO it does not make sense to add a syscall for this, please have a
look at prctl(2) instead, which is already used for similar settings.

Regards,
Willy

