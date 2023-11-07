Return-Path: <linux-api+bounces-2-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290EC7E31D4
	for <lists+linux-api@lfdr.de>; Tue,  7 Nov 2023 01:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C24280D8C
	for <lists+linux-api@lfdr.de>; Tue,  7 Nov 2023 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00041369;
	Tue,  7 Nov 2023 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2FYYS8MO"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3AB18F;
	Tue,  7 Nov 2023 00:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2A7C433C7;
	Tue,  7 Nov 2023 00:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699315253;
	bh=gWSQwVS/DuFY8epvQLsUoxyqrJ0L53S7NX9Y3cpdBb4=;
	h=Date:From:To:Subject:From;
	b=2FYYS8MOF+g1KB68wRaTBLt4qdi1oVNOVrcDhGPFKyzvQpkvWgDuhvgDRlPv0wRJ9
	 JnCnzHfzpUgAfDJzf3Ko047wJ9qpjDPxUaQ+vacrgU1ekeVhxA1SkM+w7u2PxssFC5
	 3MfQ3cbwb3IY+DCqoN+XoJe/TnyNPHlODGXbQPMA=
Date: Mon, 6 Nov 2023 19:00:52 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: lartc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-assembly@vger.kernel.org, linux-bcache@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-btrace@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-can@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-edac@vger.kernel.org, linux-efi@vger.kernel.org
Subject: PSA: this list has been migrated (no action required)
Message-ID: <20231106-courageous-soft-caiman-7b3e6a@meerkat>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello:

This list has been migrated to the new vger infrastructure. You should't need
to change anything about how you participate with the list or how you receive
mail.

If something isn't working right, please reach out to helpdesk@kernel.org.

Best regards,
Konstantin

