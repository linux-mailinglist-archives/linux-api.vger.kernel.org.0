Return-Path: <linux-api+bounces-3992-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F6AE88E2
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA98B189A4C6
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6575729C33A;
	Wed, 25 Jun 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AplTIIbf"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6D1C5489;
	Wed, 25 Jun 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866946; cv=none; b=QdmIJ40W5Np1pVWhRpbcnzz1K9CSa6Hg32PYBHISTy2CAETlkAy0bU7XG1WKx6Sa+MeYUPtWxd/v+WkuplMJ7ldzt0nqiBbYJ0NVevGD4nfrmoFyccZZ6vBKdnEaM/ELqRalYLh2uVUVGL2J3+wjszNsMWnvHcwqtYyewIilfzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866946; c=relaxed/simple;
	bh=3np5xYX9qLowbYiToyHpb8PTiLcd+xBJlnCBiyYXiKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcO+tAyC1IZgF2HL/tlyn4ErflPHTvRZo34vrwilk30HEAAaaaY4oL5q2C+0HDR2Ct+Qq1KVjyXscwa6ZRXTF4TA9juJHhqrh1yIGf+TxpWX7r4OVIe8Y1HzVACs65we7PHfJc1LGdIInTI6dm5w6AMH09DzhX8L3Vy/GH+lojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AplTIIbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51A6C4CEEA;
	Wed, 25 Jun 2025 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750866945;
	bh=3np5xYX9qLowbYiToyHpb8PTiLcd+xBJlnCBiyYXiKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AplTIIbfx7WTN+4phIeh3dRdnCNxln2iQIjLbYe1gf0PlMnOgukNgrRoIW6Oi/h6s
	 95Wokse44GIov0mkI91EyIbwHib/RzMuLD2Gp0c30v3J4MhEt3bcPBVvQt1boc+AdO
	 bjd1Eg7TGtiHRVR5gtoZmwPon7tofYBtGLLFlYSVOmDCN//7wLtSOuI4W5hoKZJDpr
	 zBakkMgKoNqbKodkXuKquqp0UDZsaqsvP6VMW7GNdyXPSByHuJBsnQvWTDbKFgooZN
	 FL5q8t92+CuDytc6Bgg28nvlpEcYE2P0aPxSDivAcVjyUKxdx5RVxwFStW/WOKHLG4
	 NjEdOgAx7nYMg==
Date: Wed, 25 Jun 2025 11:55:43 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, tools@kernel.org,
	workflows@vger.kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <aFwb_3EE2VMEV_tf@lappy>
References: <aFNYQkbEctT6N0Hb@lappy>
 <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy>
 <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>

On Wed, Jun 25, 2025 at 10:52:46AM +0200, Dmitry Vyukov wrote:
>On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:
>
>> >6. What's the goal of validation of the input arguments?
>> >Kernel code must do this validation anyway, right.
>> >Any non-trivial validation is hard, e.g. even for open the validation function
>> >for file name would need to have access to flags and check file precense for
>> >some flags combinations. That may add significant amount of non-trivial code
>> >that duplicates main syscall logic, and that logic may also have bugs and
>> >memory leaks.
>>
>> Mostly to catch divergence from the spec: think of a scenario where
>> someone added a new param/flag/etc but forgot to update the spec - this
>> will help catch it.
>
>How exactly is this supposed to work?
>Even if we run with a unit test suite, a test suite may include some
>incorrect inputs to check for error conditions. The framework will
>report violations on these incorrect inputs. These are not bugs in the
>API specifications, nor in the test suite (read false positives).

Right now it would be something along the lines of the test checking for
an expected failure message in dmesg, something along the lines of:

	https://github.com/linux-test-project/ltp/blob/0c99c7915f029d32de893b15b0a213ff3de210af/testcases/commands/sysctl/sysctl02.sh#L67

I'm not opposed to coming up with a better story...

-- 
Thanks,
Sasha

