Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64050224C6A
	for <lists+linux-api@lfdr.de>; Sat, 18 Jul 2020 17:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGRPXk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 18 Jul 2020 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRPXk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 18 Jul 2020 11:23:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8E8C0619D2
        for <linux-api@vger.kernel.org>; Sat, 18 Jul 2020 08:23:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d1so6716230plr.8
        for <linux-api@vger.kernel.org>; Sat, 18 Jul 2020 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ilc6FNBUK60Q0NzICroIaLXxto4fB7XBaBWKqz4EmWw=;
        b=vdS6vjlSZiHLkFDcyANUS+YV3iAftUEMU2UcqKikwy9uOk+JkauClMroQIWIEyeOAo
         YqC9G/yohI40BCL7bT8/jUngtSsT8R8oa3LnN6T1dEqF3OvNUHAX5yVeD5h3lz39Kg2L
         x4MtUDA6mhFfV1sAC5ABHhMsiJ8IIb/eKysyOrCdvWxmhgo8bekoenn0dG10CuAQK2bU
         fx+Asp7+7Xl9y+8/Hib0yvZbZ3kAt0+aYyeXHnEf+Fj3/kltgurFx4LBMy6lJIuvHTFw
         byVvlHhjKjHDkX0omhBe4C1aQZqPS8YYli3dIJ+u7Vq67I3kYU6aAxZ9A931/niZOd5e
         XBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ilc6FNBUK60Q0NzICroIaLXxto4fB7XBaBWKqz4EmWw=;
        b=gelbAQy3eC1EHM85OXJV3Q2rqD4Wqtl3cHkh+Jk8QCKQN1NN6b0vazoLWrD0G7ZONL
         CvrPCL2vxDGkrFepyUbIZLt0WKTyktMEFy/0/tAw9fT9+Ej+E+M+G15YLjegeZ/ULHD5
         SIuz4VU+ld5xv2SvvO6aPg8avlW4AYD8vh6y0IFQcvOUI2NuFJnRoB4zAEKhrWZUnAP0
         qU5OrbcHJN2q9RJ3Bn8jfjy/sghR5WJYDzidwUD+bSk+QU1cQhwnVGTxRYVx7kQacP4F
         Y3S3+EaPYJLFVCoxxuAqngNg8jN6qcQKp7Je3ZPrLrOvhmtxmB3nHcQjyA4sliKvXGEi
         469g==
X-Gm-Message-State: AOAM5325XHiIvgyx3ad0rwGrcr+D3QeGhod+qCB8UaOWWwDDXlysaxgJ
        BIPfQXC9CdKivvd/GLl/xqI=
X-Google-Smtp-Source: ABdhPJwGwHFHb3cu4he9GyblC9bE25A509Oi/TLMyTY1prTESUvCfAKg9jqxxBgMvONY9HaJKDG+1w==
X-Received: by 2002:a17:90a:80c3:: with SMTP id k3mr14688170pjw.102.1595085819909;
        Sat, 18 Jul 2020 08:23:39 -0700 (PDT)
Received: from linux-kernel-source.asia-southeast1-b.c.hardy-notch-265411.internal (3.136.240.35.bc.googleusercontent.com. [35.240.136.3])
        by smtp.gmail.com with ESMTPSA id h15sm11067808pfo.192.2020.07.18.08.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 08:23:39 -0700 (PDT)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     tglx@linutronix.de, trivial@kernel.org
Cc:     linux-api@vger.kernel.org
Subject: 
Date:   Sat, 18 Jul 2020 15:23:21 +0000
Message-Id: <20200718152322.4429-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718150847.4052-2-minhquangbui99@gmail.com>
References: <20200718150847.4052-2-minhquangbui99@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I'm so sorry for spaming your email. I figure out some mistakes with last patch.
The patch follows your recommendation on removing all file references.

Thank you for your time,
Bui Quang Minh

