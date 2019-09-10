Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C67AE785
	for <lists+linux-api@lfdr.de>; Tue, 10 Sep 2019 12:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405456AbfIJKDY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Sep 2019 06:03:24 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56504 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405452AbfIJKDY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Sep 2019 06:03:24 -0400
Received: by mail-pg1-f202.google.com with SMTP id h5so10323748pgq.23
        for <linux-api@vger.kernel.org>; Tue, 10 Sep 2019 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r40Km9SeMoEAm8w6fV7cNpDnhYcE+rjMqoH130Kp7BE=;
        b=sHdbong61Qoi+BbIKKGln345Qiy3DeqhOHgCul55SvBFdXYKycYt9HdpvP4vOwUtRA
         e6XeqPWVJfzS8Mprr6lyw7diodw1kI/Clox6b/90uCbDDsTULGvWnAwQID0XOxQeRwrr
         FP6UHyX3aP1J8Df1uaoNBjipHfLQ/ayxBfs5HDNGp14O4t7RA5VC3Y4o3xEyijxcunTp
         1dR/Ptyb6pyaczugc9pQYj9p4E9ce7jzRL41Y7FnTms/phFh8IEDvs/g1FJHXtyRdojh
         O0gxHJNkgFQDTwYt4kzQu7N1y6wiJwzj4TkX+lW3IifPWc2FAPyKZIcjOKtnruuocAwo
         xlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r40Km9SeMoEAm8w6fV7cNpDnhYcE+rjMqoH130Kp7BE=;
        b=T1MelbKOPK3DvEDtx5b7W66e0kh9L6zI2nGn/m6odPM4iNebflIMEugXH6UkiXgLhO
         29znbjL/9C5ItizQXN4orEBUEjojVig9spbY4+HbSH/EGHB7HgIUtFUFtYao4Fkon/TE
         IiJJZ4UIN5jIToemTC7DcuvdIYzfyOh9cjNx6JW/L8ZsslJCo9qt/UirPz+9two0I0er
         yy0B0qAsqH+MiWtj4qaKFfDG1MqV738MjmODOSQaaek31myy2RZUEpiG2OlZ9loRJKzP
         PSDO8w6QyLdzfOuzKwbNp1u9Vw0CI0vCBZHzsEFWfEMIKX1U/tJD+xte918lvaP7SbnJ
         dKLg==
X-Gm-Message-State: APjAAAXUJYnT9Vnm1pIonWqSPZSPXvOU3vtZA1wkl1aorFbn4IRKZHeK
        2VfNpE4YtTEZXioJU2IGGCu6Jh+0NrA9nqR3rizBmQ==
X-Google-Smtp-Source: APXvYqym4YdfN5NCZ635dtgyN0Mo3OO0Abij86ACeO+9MdGWn1hlEjvLlL151v1Oriv9nU/uiKBEfgMcr+VXJAs55COPww==
X-Received: by 2002:a65:6904:: with SMTP id s4mr26903237pgq.33.1568109803251;
 Tue, 10 Sep 2019 03:03:23 -0700 (PDT)
Date:   Tue, 10 Sep 2019 03:03:16 -0700
Message-Id: <20190910100318.204420-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 0/2] Minor lockdown fixups
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Constify some arrays and fix an #ifdef that I typoed.


