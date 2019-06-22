Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E2C4F21B
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFVAEC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:02 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39837 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFVAEC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:02 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so5324131pfi.6
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AAeO9wmZHoIAW85/YZsA08PAPEbpIlmFs1RDEybHYxQ=;
        b=RpygPNq+20LtS5zv7Sg4bv8+t7+1nozkqguEx2JIaZRR4ljxyH+W9K5rQ80BGRvOjm
         m70JjWNugeKsg7+m3YxPJ2QU0y4u3qP8YKF4V6G9vLYqyz4leIeIWkkt2nQGSIgVijsu
         Kw1cu+jDzfTzJPoWCOQgf8Quqx6BZED39mdP4wsXJzfLBqeFbBGPZaXGXrTAtLXLvKIs
         UOq1PYm/bvnh7L0WNr3z9GBxKg2OxQ2U25b0wy+9tI9mEQC5URsKSngfThgF8UT4SXzc
         UdMRIaqiIV09ci1VT4cgLDypHPLAqfKN7Q++YOeuhbIcbvMD8wdMD/3WjNDkWIlwmpar
         2YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AAeO9wmZHoIAW85/YZsA08PAPEbpIlmFs1RDEybHYxQ=;
        b=BMOO4vU+wUoZ0A9XD9uaAxlv8XmMYxeFR9X7IcuOzGrbY/B4XeuWuC8SBs/eWSz/AV
         5ELRwFTSbVuI9TPDeqqZi7WS7EhDaCiborVuvgzdC7Q5IDNWHRqZJxOaADjUalmUR7MO
         N3Tn+QzQJuutbQrrHs0eiwrUs473bF33PkUK8982BMG5pgapqn4/WPkYWsCcdgVMKOLo
         d5C2c++oVI69GW5dD7tsgFQKea3dIpXb3X1pjWa3DOCFUqYooD78Vg8HfzdBXr6z+2Fg
         eVSJWbM8izJocvDQBN1vTcnDuG2bzqVO+NY6EBaAC6XEchHpvmdB6tIth2D3JZWBb1S0
         VCBg==
X-Gm-Message-State: APjAAAW+BtIO16ec3NLs4CrNOen/q2Mgm3z/f3lWJc2pKWwsykzHViVc
        xSqsssttq3JgHSN2ilkMCiohy792Vk0FYjx5ZzJDxg==
X-Google-Smtp-Source: APXvYqzNKH2CB7jrIAqDTxw++WsPlYTl6BNi9HPgLMKvWqNcLHGXI/QsRQGJA1/9p4e25dw0fvSPiBPDZ2no9JeN5x7/+w==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr10503150pgm.10.1561161841204;
 Fri, 21 Jun 2019 17:04:01 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:29 -0700
Message-Id: <20190622000358.19895-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 00/29] Lockdown as an LSM
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Minor updates over V33 - security_is_locked_down renamed to
security_locked_down, return value of security_locked_down is returned
in most cases, one unnecessary patch was dropped, couple of minor nits
fixed.


