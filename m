Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A66B3AA543
	for <lists+linux-api@lfdr.de>; Wed, 16 Jun 2021 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhFPU21 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Jun 2021 16:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbhFPU20 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Jun 2021 16:28:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98795C061760
        for <linux-api@vger.kernel.org>; Wed, 16 Jun 2021 13:26:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso4749535pjb.0
        for <linux-api@vger.kernel.org>; Wed, 16 Jun 2021 13:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zi6CxSdFzJAU/uJ8a5qyyg176z2pYarS7df6bpLiqLs=;
        b=aX6jc6zprHZ43mJUwdioAb6eOdkAIYSqiTwpLB5yQlKOZb8kCeR+jE9eiVkmuWrC60
         QO8dHZWrF7WXUZWH8/XJA4w1lzkhnNwIXfiNQOTzcCzTu0hhoOANqj+koouM4YDRHPf4
         pC5yvVDdpWU2AgDlGZc430Qjitj+SeiTil6eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zi6CxSdFzJAU/uJ8a5qyyg176z2pYarS7df6bpLiqLs=;
        b=ryWYZ19xZXFwSEaSHR2TWBAtf8YmUJrI1REQuUeObnN+tx3IERNwMsIxwZ9iP/U3/R
         KuzP3VGlZOOrkNfAEHTtpDalofwDhwnRMmuptaXVvYyFWakNgaXrPqFCz4qmUZnwTthi
         5y7CmpqsQSfoZ6CUOZKA5i2RsqpxyL0DAwC6QC2olbKEXSBrv+xbG54ZtPnyFDOuNbfL
         gx4KfTkoMygj8V8ax4sToYbzdH0slQ9WiCR0rYzxWM4y5nBKp1DxhY127CDZmKbBG9pe
         0QwUuWcnDbwfnFq1wz4NRZIrndBl7MZU1TCxOpCD6qXWM4u3oLlfle0hq2rlE/1VArmA
         BMhQ==
X-Gm-Message-State: AOAM533GN/Oq/98Fewi9JQm8zq27mH37SWJALi41TlD4tNGWqeZS9f9D
        0Re9VO9/4BRw5du3v4z91IAuHg==
X-Google-Smtp-Source: ABdhPJy70PETPLLA7ZceudoYAyvQR2YlLTVuaYUK00rS4eyaJVS5ue1+YPGv2YPyNzVPyQQhBjucSA==
X-Received: by 2002:a17:902:b94c:b029:117:9c88:7744 with SMTP id h12-20020a170902b94cb02901179c887744mr1243178pls.20.1623875178044;
        Wed, 16 Jun 2021 13:26:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15sm3044037pgg.23.2021.06.16.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:26:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-api@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] RDMA/core: Use flexible array for mad data
Date:   Wed, 16 Jun 2021 13:26:15 -0700
Message-Id: <20210616202615.1247242-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=0f6e0b848f8b2a913015c9c030e5ea98deef9dd8; i=SiK2ULITvZfMNXmqRkr+ofG4gpql69b9o2o0ISRPW4c=; m=fvxiQzqzCA9QcgKSJbJ11pTGymCFRvYOOBlP5e4hgLU=; p=CQ7QTMm85lc4Pgf70Hbu6eKIHRL8Wkals6mfT8l9lfE=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKXmYACgkQiXL039xtwCZUIhAAmbc fSd5myhlaGN/jMAAF00rs3BZucrXnarQz+pUo4jMYg3H74eGHZXTEIxZuzz31LVqKNnVaPwn9Dulf 6vfBC6R7xgVa2itbSGgmKjZqc9PjipIbq5OZXqsNQSFhnrNF2yM2vnW2THPE7t0P+AgQi3L0+71ti xAi4P0F3wm0KGBbLwZjJ5uzQGQxafo/WmTOs+aNBdvtjaphiR01jOzRgkEL2YCa0WbkkKJlosEX3p tYDCV737ekukksTWBcvWTHfYFZYwKtGd/EBy53H/5RO5znlByzucnRl+pT08UZZPJw6mi91+7X3MR 7RsFCOvVGDQ8tPNpVBl85pokbb3CczKwEjk0qI12yU6MnUpLzwOsgBPEQZf3pTxo+8gkl69PC4hLH Aj03+EaHaduP0I3dOUyt4EZqqyihu/vbziilz8Ts51LwZyTF3zi8NJC+JdP7ODUVQ/QyIyIATexQV SMBJPh42E2LMe/5mZNrL4kgMBZokPbxtnpqvpl5kbGOdkzOAGaG60yz+Aj4bhbwNsvmzP/zKTiIBD ++4wpvw/6iON4fXoQZNdCCa6PTNLasiZo/h0+9Zc4xB2wTRraDJmn8P7SBGDuqwhdRt0Mjc7YWG07 1Y68hnZdy6m+30X2JglzbTwkWgUjb67Esa9MNoUo+Nz0dYu37W5el+hGnhPBd9FY=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally read across neighboring array fields.

Without a flexible array, this looks like an attempt to perform a
memcpy() read beyond the end of the packet->mad.data array:

drivers/infiniband/core/user_mad.c:
	memcpy(packet->msg->mad, packet->mad.data, IB_MGMT_MAD_HDR);

Switch from [0] to [] to use the appropriately handled type for trailing
bytes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/rdma/ib_user_mad.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/rdma/ib_user_mad.h b/include/uapi/rdma/ib_user_mad.h
index 90c0cf228020..10b5f6a4c677 100644
--- a/include/uapi/rdma/ib_user_mad.h
+++ b/include/uapi/rdma/ib_user_mad.h
@@ -143,7 +143,7 @@ struct ib_user_mad_hdr {
  */
 struct ib_user_mad {
 	struct ib_user_mad_hdr hdr;
-	__aligned_u64	data[0];
+	__aligned_u64	data[];
 };
 
 /*
-- 
2.25.1

