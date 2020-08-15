Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1FD2453B7
	for <lists+linux-api@lfdr.de>; Sun, 16 Aug 2020 00:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgHOWEf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 15 Aug 2020 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgHOVvB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 15 Aug 2020 17:51:01 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F646C004583
        for <linux-api@vger.kernel.org>; Sat, 15 Aug 2020 11:24:02 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l204so11181130oib.3
        for <linux-api@vger.kernel.org>; Sat, 15 Aug 2020 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WD7gDl+XCmPqlIM7nO2KOimmNxRDcsCujVimXn1HcY=;
        b=g4DTmlN0AX+cftqo1QEpMKcjQk7ZLxWak6EyvPZavjAmBIk8W1XU8uNdWZCTLi1DW6
         DVT6Hhi6wWp4aBdUSYuGixUeEKS0TAC+Cttb3icJugW6uKVYJcwIWLbU6HY9ZpjqRk93
         TJivnlGJ5p2LOhQabFmwvkVDTnN1kZQuXElbRNiIA5/Lq7bimj65Y2kxx92n0v/XcQzc
         KJXsSBW1G4fZGw+G4fxmPBgSuBhW2sI2qFaeni0qQfISXO6Fpa8oJwoOnkwr2xdukwJj
         q88RPcEN0CeiSwHbpisoTCWPyghNabqi4ZRUUqqVtogrSGbuGQKNp61Y5oEZSTC1KHEJ
         dVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WD7gDl+XCmPqlIM7nO2KOimmNxRDcsCujVimXn1HcY=;
        b=VGW2Bqew0aHTtOijmIvhaoClTfF7YIsmMX8ATYUsi54ExuktwuKaDEZJ4Jk0wdyHDz
         vriC5rdwD+iCOw/1NAJX+5nqp/2aa164Hb16CsUTwdEg5c3p09G0v3HdmpiQUHNqC6iN
         wMx3ZuyrvSiDnq/GrbRL7YBtSW/J3Es06S0Ian/BMUg2qX4f7kv3uxZvsmjuSZx4n6/x
         2T23Y1723nq6oFsYwAuwB4C0s96A+pXi6o0IhBAIPeGBdyll+q/3Tc66s0Q7f5X7A4rr
         KcFGfvu3Gq1h004Z90S/NjoR1yPlUSAs8lhaMfyR4fmtm3ugNtUsG7wY0GaYTRXFlj8D
         mBGQ==
X-Gm-Message-State: AOAM531+VHB30fuYmQ2I9PO6S+w1fJKLtxEi9Bi0iHPEDXwiILjPlm07
        72mtitXW6BhcN6g7HGE31/8KrA==
X-Google-Smtp-Source: ABdhPJxqwP+YD3muYShKpb0m6VaIwQRrEiPMwvh26QMq87kIaKeWCvE0KzX/JwlMmukEVl0cU0TLwg==
X-Received: by 2002:aca:e144:: with SMTP id y65mr4848449oig.101.1597515841901;
        Sat, 15 Aug 2020 11:24:01 -0700 (PDT)
Received: from foo.attlocal.net (108-232-117-128.lightspeed.sntcca.sbcglobal.net. [108.232.117.128])
        by smtp.gmail.com with ESMTPSA id z72sm2397820ooa.42.2020.08.15.11.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 11:24:01 -0700 (PDT)
From:   Pascal Bouchareine <kalou@tfz.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Pascal Bouchareine" <kalou@tfz.net>
Subject: [RFC PATCH 0/2] proc,socket: attach description to sockets
Date:   Sat, 15 Aug 2020 11:23:42 -0700
Message-Id: <20200815182344.7469-1-kalou@tfz.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Checking to see if this could fit in struct sock.

This goes against v5.8

I tried to make it tl;dr in commit 2/2 but motivation is also described
a bit in https://lore.kernel.org/linux-api/CAGbU3_nVvuzMn2wo4_ZKufWcGfmGsopVujzTWw-Bbeky=xS+GA@mail.gmail.com/

