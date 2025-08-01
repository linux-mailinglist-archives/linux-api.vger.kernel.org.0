Return-Path: <linux-api+bounces-4278-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30ECB182FC
	for <lists+linux-api@lfdr.de>; Fri,  1 Aug 2025 15:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB099A86713
	for <lists+linux-api@lfdr.de>; Fri,  1 Aug 2025 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517B9262FC2;
	Fri,  1 Aug 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxD1unUZ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB125743E;
	Fri,  1 Aug 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056422; cv=none; b=Wcl+l8wEdUksTH8I4ru+SMhnR6wq2iqPbCK+zsO4OFf6NfCb5rAGys0KPKBJS6iM2nDaFRF3zUKOkNMmhgD2712Kust5EBUJgl/xIYzsOlO2CZb+t3JsyGSIa8Kgla0m0vAXn1TInxIvVl4R+jduXQ7+Q6dihiNg5MsRVGVkUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056422; c=relaxed/simple;
	bh=b7ygX6fWwlwQdIKjpdQKH7R9GKsbUErT1h3IkhEGH4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1U7+cdmdsDTTosltUgxULPmvf/zw4nIgXJ/GDQMsOwOtotW6IrtKxBrz385CUJdrJMLzOWHvd4L+z20g9zQczDyfWOgT/pynDUXpdR9OaECwIGnRDuhd0AEhvDkzmowtqYDr2BV/nOABOO8rNJDIyy/6dlbiBmFx59/B5XBDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxD1unUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6719FC4CEE7;
	Fri,  1 Aug 2025 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754056421;
	bh=b7ygX6fWwlwQdIKjpdQKH7R9GKsbUErT1h3IkhEGH4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxD1unUZAB8LYpWdEQisRXcII9uw2jI35fEvNsBhKs9M4PQ4VOyWS3Z+1ZWXdFvkN
	 tjdKtYXjM/P/rKwwyW1sU+3kGZlcT6oIvKi+IE+jH5L4Sv354OwBDOATYU+KnPmPuc
	 zaWTvf0AM9E+t1Kh6STn7bXeAaHkxQEJOWtMQSuW2brUOhGOCzqpQU4mZoUhDBXWvn
	 S34V+pKiAPQamq+adn20HlFFGBd9FSyMsB2nkCdqiuyd0B0QLjZbeyFzeaosT56zz5
	 sijeZwsjrCpY1E+yWowv0xXWauUi6ekgHQ9CUmdslXjWrxcoQQ+rypbKS5kiWx+L+8
	 pEw2GxUcuj38A==
Date: Fri, 1 Aug 2025 09:53:39 -0400
From: Sasha Levin <sashal@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC v3 1/4] kernel/api: introduce kernel API specification
 framework
Message-ID: <aIzG427WYt0_wonN@lappy>
References: <20250711114248.2288591-2-sashal@kernel.org>
 <20250716072141.12-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250716072141.12-1-safinaskar@zohomail.com>

On Wed, Jul 16, 2025 at 10:21:41AM +0300, Askar Safin wrote:
>> +   KAPI_PARAM_IN       = (1 << 0),
>> +   KAPI_PARAM_OUT      = (1 << 1),
>> +   KAPI_PARAM_INOUT    = (1 << 2),
>
>There is no need for KAPI_PARAM_INOUT. It could be replaced by KAPI_PARAM_IN | KAPI_PARAM_OUT

It could, but it's easier to write _INOUT :)

-- 
Thanks,
Sasha

