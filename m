Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8855C2C47F8
	for <lists+linux-api@lfdr.de>; Wed, 25 Nov 2020 19:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKYSy4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Nov 2020 13:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731057AbgKYSy4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Nov 2020 13:54:56 -0500
Received: from localhost.localdomain (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CD020674;
        Wed, 25 Nov 2020 18:54:54 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-api@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 1/2] kasan: arm64: set TCR_EL1.TBID1 when enabled
Date:   Wed, 25 Nov 2020 18:54:52 +0000
Message-Id: <160633041769.14178.5621643710037826918.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
References: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, 21 Nov 2020 01:59:02 -0800, Peter Collingbourne wrote:
> On hardware supporting pointer authentication, we previously ended up
> enabling TBI on instruction accesses when tag-based ASAN was enabled,
> but this was costing us 8 bits of PAC entropy, which was unnecessary
> since tag-based ASAN does not require TBI on instruction accesses. Get
> them back by setting TCR_EL1.TBID1.

Applied to arm64 (for-next/misc), thanks!

[1/2] kasan: arm64: set TCR_EL1.TBID1 when enabled
      https://git.kernel.org/arm64/c/49b3cf035edc

This patch looks safe. Patch 2/2 needs more discussions.

-- 
Catalin

