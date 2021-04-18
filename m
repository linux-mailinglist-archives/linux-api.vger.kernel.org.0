Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C43634B0
	for <lists+linux-api@lfdr.de>; Sun, 18 Apr 2021 12:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhDRLAB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 18 Apr 2021 07:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhDRK76 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 18 Apr 2021 06:59:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD61E610EA;
        Sun, 18 Apr 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618743570;
        bh=wYeoVDzgP9pvRg7BUpaZz18lOEdk5XaB2NM1y+JxHwU=;
        h=From:To:Cc:Subject:Date:From;
        b=X7E4fJTzbTbD3dld8Y9DmdpQZmjJiztsOCkOgj/2BdwCH3k7Xues5GSMeUs0E0P83
         00Alq2kzU+2qK+UnvgR/PFI6hBdv3/BkxyqoDobvDLpAXNWz0xxiorSKyAkVi/50XG
         7xk0tWJW7Ki5rBvoFihHDFhBdKH/1APjnmsBcOOwcMVwj6POxUFM5rbzpZe5k3VORL
         In0Zx2KOpk3JIaLNlpjl1tQCD3PzmD3XTjzDLiyA5pbbD/ZapRRHjCt1fNs+8T3Zq6
         ewRjGm5DC2/usNg7sb0K1SiVnTxuifps0sr8UBnnL/acZZhxaShXDYgCKNa15tjZqi
         hyg9iqV3iNk4A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>, linux-api@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next v3] RDMA/mlx5: Expose private query port
Date:   Sun, 18 Apr 2021 13:59:21 +0300
Message-Id: <6e2ef13e5a266a6c037eb0105eb1564c7bb52f23.1618743394.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mark Bloch <mbloch@nvidia.com>

Expose a non standard query port via IOCTL that will be used to expose
port attributes that are specific to mlx5 devices.

The new interface receives a port number to query and returns a
structure that contains the available attributes for that port.
This will be used to fill the gap between pure DEVX use cases
and use cases where a kernel needs to inform userspace about
various kernel driver configurations that userspace must use
in order to work correctly.

Flags is used to indicate which fields are valid on return.

MLX5_IB_UAPI_QUERY_PORT_VPORT:
	The vport number of the queered port.

MLX5_IB_UAPI_QUERY_PORT_VPORT_VHCA_ID:
	The VHCA ID of the vport of the queered port.

MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_RX:
	The vport's RX ICM address used for sw steering.

MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_TX:
	The vport's TX ICM address used for sw steering.

MLX5_IB_UAPI_QUERY_PORT_VPORT_REG_C0:
	The metadata used to tag egress packets of the vport.

MLX5_IB_UAPI_QUERY_PORT_ESW_OWNER_VHCA_ID:
	The E-Switch owner vhca id of the vport.

Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v3:
 * declared "info" variable on stack
v2: https://lore.kernel.org/linux-api/20210401085004.577338-1-leon@kernel.org
 * Changed __u64 to be __aligned_u64 in the uapi header
v1: https://lore.kernel.org/linux-api/20210322093932.398466-1-leon@kernel.org
 * Missed sw_owner check for CX-6 device, fixed it.
v0: https://lore.kernel.org/linux-api/20210318135221.681014-1-leon@kernel.org
---
 drivers/infiniband/hw/mlx5/std_types.c    | 173 ++++++++++++++++++++++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h  |   9 ++
 include/uapi/rdma/mlx5_user_ioctl_verbs.h |  25 ++++
 3 files changed, 207 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/std_types.c b/drivers/infiniband/hw/mlx5/std_types.c
index 16145fda68d0..c0ddf7b3c6e2 100644
--- a/drivers/infiniband/hw/mlx5/std_types.c
+++ b/drivers/infiniband/hw/mlx5/std_types.c
@@ -7,6 +7,8 @@
 #include <rdma/mlx5_user_ioctl_cmds.h>
 #include <rdma/mlx5_user_ioctl_verbs.h>
 #include <linux/mlx5/driver.h>
+#include <linux/mlx5/eswitch.h>
+#include <linux/mlx5/vport.h>
 #include "mlx5_ib.h"
 
 #define UVERBS_MODULE_NAME mlx5_ib
@@ -23,6 +25,174 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_PD_QUERY)(
 			      &mpd->pdn, sizeof(mpd->pdn));
 }
 
+static int fill_vport_icm_addr(struct mlx5_core_dev *mdev, u16 vport,
+			       struct mlx5_ib_uapi_query_port *info)
+{
+	u32 out[MLX5_ST_SZ_DW(query_esw_vport_context_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(query_esw_vport_context_in)] = {};
+	bool sw_owner_supp;
+	u64 icm_rx;
+	u64 icm_tx;
+	int err;
+
+	sw_owner_supp = MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, sw_owner) ||
+			MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, sw_owner_v2);
+
+	if (vport == MLX5_VPORT_UPLINK) {
+		icm_rx = MLX5_CAP64_ESW_FLOWTABLE(mdev,
+			sw_steering_uplink_icm_address_rx);
+		icm_tx = MLX5_CAP64_ESW_FLOWTABLE(mdev,
+			sw_steering_uplink_icm_address_tx);
+	} else {
+		MLX5_SET(query_esw_vport_context_in, in, opcode,
+			 MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT);
+		MLX5_SET(query_esw_vport_context_in, in, vport_number, vport);
+		MLX5_SET(query_esw_vport_context_in, in, other_vport, true);
+
+		err = mlx5_cmd_exec_inout(mdev, query_esw_vport_context, in,
+					  out);
+
+		if (err)
+			return err;
+
+		icm_rx = MLX5_GET64(
+			query_esw_vport_context_out, out,
+			esw_vport_context.sw_steering_vport_icm_address_rx);
+
+		icm_tx = MLX5_GET64(
+			query_esw_vport_context_out, out,
+			esw_vport_context.sw_steering_vport_icm_address_tx);
+	}
+
+	if (sw_owner_supp && icm_rx) {
+		info->vport_steering_icm_rx = icm_rx;
+		info->flags |=
+			MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_RX;
+	}
+
+	if (sw_owner_supp && icm_tx) {
+		info->vport_steering_icm_tx = icm_tx;
+		info->flags |=
+			MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_TX;
+	}
+
+	return 0;
+}
+
+static int fill_vport_vhca_id(struct mlx5_core_dev *mdev, u16 vport,
+			      struct mlx5_ib_uapi_query_port *info)
+{
+	size_t out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
+	void *out;
+	int err;
+
+	out = kzalloc(out_sz, GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
+	MLX5_SET(query_hca_cap_in, in, other_function, true);
+	MLX5_SET(query_hca_cap_in, in, function_id, vport);
+	MLX5_SET(query_hca_cap_in, in, op_mod,
+		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE |
+		 HCA_CAP_OPMOD_GET_CUR);
+
+	err = mlx5_cmd_exec(mdev, in, sizeof(in), out, out_sz);
+	if (err)
+		goto out;
+
+	info->vport_vhca_id = MLX5_GET(query_hca_cap_out, out,
+				       capability.cmd_hca_cap.vhca_id);
+
+	info->flags |= MLX5_IB_UAPI_QUERY_PORT_VPORT_VHCA_ID;
+out:
+	kfree(out);
+	return err;
+}
+
+static int fill_switchdev_info(struct mlx5_ib_dev *dev, u32 port_num,
+			       struct mlx5_ib_uapi_query_port *info)
+{
+	struct mlx5_core_dev *mdev = dev->mdev;
+	struct mlx5_eswitch_rep *rep;
+	int err;
+
+	rep = dev->port[port_num - 1].rep;
+	if (!rep)
+		return -EOPNOTSUPP;
+
+	info->vport = rep->vport;
+	info->flags |= MLX5_IB_UAPI_QUERY_PORT_VPORT;
+
+	if (rep->vport != MLX5_VPORT_UPLINK) {
+		err = fill_vport_vhca_id(mdev, rep->vport, info);
+		if (err)
+			return err;
+	}
+
+	info->esw_owner_vhca_id = MLX5_CAP_GEN(mdev, vhca_id);
+	info->flags |= MLX5_IB_UAPI_QUERY_PORT_ESW_OWNER_VHCA_ID;
+
+	err = fill_vport_icm_addr(mdev, rep->vport, info);
+	if (err)
+		return err;
+
+	if (mlx5_eswitch_vport_match_metadata_enabled(mdev->priv.eswitch)) {
+		info->reg_c0.value = mlx5_eswitch_get_vport_metadata_for_match(
+			mdev->priv.eswitch, rep->vport);
+		info->reg_c0.mask = mlx5_eswitch_get_vport_metadata_mask();
+		info->flags |= MLX5_IB_UAPI_QUERY_PORT_VPORT_REG_C0;
+	}
+
+	return 0;
+}
+
+static int UVERBS_HANDLER(MLX5_IB_METHOD_QUERY_PORT)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct mlx5_ib_uapi_query_port info = {};
+	struct mlx5_ib_ucontext *c;
+	struct mlx5_ib_dev *dev;
+	u32 port_num;
+	int ret;
+
+	if (uverbs_copy_from(&port_num, attrs,
+			     MLX5_IB_ATTR_QUERY_PORT_PORT_NUM))
+		return -EFAULT;
+
+	c = to_mucontext(ib_uverbs_get_ucontext(attrs));
+	if (IS_ERR(c))
+		return PTR_ERR(c);
+	dev = to_mdev(c->ibucontext.device);
+
+	if (!rdma_is_port_valid(&dev->ib_dev, port_num))
+		return -EINVAL;
+
+	if (mlx5_eswitch_mode(dev->mdev) == MLX5_ESWITCH_OFFLOADS) {
+		ret = fill_switchdev_info(dev, port_num, &info);
+		if (ret)
+			return ret;
+	}
+
+	return uverbs_copy_to_struct_or_zero(attrs, MLX5_IB_ATTR_QUERY_PORT, &info,
+					     sizeof(info));
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	MLX5_IB_METHOD_QUERY_PORT,
+	UVERBS_ATTR_PTR_IN(MLX5_IB_ATTR_QUERY_PORT_PORT_NUM,
+			   UVERBS_ATTR_TYPE(u32), UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(
+		MLX5_IB_ATTR_QUERY_PORT,
+		UVERBS_ATTR_STRUCT(struct mlx5_ib_uapi_query_port,
+				   reg_c0),
+		UA_MANDATORY));
+
+ADD_UVERBS_METHODS(mlx5_ib_device,
+		   UVERBS_OBJECT_DEVICE,
+		   &UVERBS_METHOD(MLX5_IB_METHOD_QUERY_PORT));
+
 DECLARE_UVERBS_NAMED_METHOD(
 	MLX5_IB_METHOD_PD_QUERY,
 	UVERBS_ATTR_IDR(MLX5_IB_ATTR_QUERY_PD_HANDLE,
@@ -41,5 +211,8 @@ const struct uapi_definition mlx5_ib_std_types_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE(
 		UVERBS_OBJECT_PD,
 		&mlx5_ib_pd),
+	UAPI_DEF_CHAIN_OBJ_TREE(
+		UVERBS_OBJECT_DEVICE,
+		&mlx5_ib_device),
 	{},
 };
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 3798cbcb9021..ca2372864b70 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -320,4 +320,13 @@ enum mlx5_ib_pd_methods {
 
 };
 
+enum mlx5_ib_device_methods {
+	MLX5_IB_METHOD_QUERY_PORT = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum mlx5_ib_query_port_attrs {
+	MLX5_IB_ATTR_QUERY_PORT_PORT_NUM = (1U << UVERBS_ID_NS_SHIFT),
+	MLX5_IB_ATTR_QUERY_PORT,
+};
+
 #endif
diff --git a/include/uapi/rdma/mlx5_user_ioctl_verbs.h b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
index 56b26eaea083..a21ca8ece8db 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_verbs.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
@@ -83,5 +83,30 @@ enum mlx5_ib_uapi_uar_alloc_type {
 	MLX5_IB_UAPI_UAR_ALLOC_TYPE_NC = 0x1,
 };
 
+enum mlx5_ib_uapi_query_port_flags {
+	MLX5_IB_UAPI_QUERY_PORT_VPORT			= 1 << 0,
+	MLX5_IB_UAPI_QUERY_PORT_VPORT_VHCA_ID		= 1 << 1,
+	MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_RX	= 1 << 2,
+	MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_TX	= 1 << 3,
+	MLX5_IB_UAPI_QUERY_PORT_VPORT_REG_C0		= 1 << 4,
+	MLX5_IB_UAPI_QUERY_PORT_ESW_OWNER_VHCA_ID	= 1 << 5,
+};
+
+struct mlx5_ib_uapi_reg {
+	__u32 value;
+	__u32 mask;
+};
+
+struct mlx5_ib_uapi_query_port {
+	__aligned_u64 flags;
+	__u16 vport;
+	__u16 vport_vhca_id;
+	__u16 esw_owner_vhca_id;
+	__u16 rsvd0;
+	__aligned_u64 vport_steering_icm_rx;
+	__aligned_u64 vport_steering_icm_tx;
+	struct mlx5_ib_uapi_reg reg_c0;
+};
+
 #endif
 
-- 
2.30.2

